require "spec_helper"

module XpmRuby
  RSpec.describe(Connection) do
    let(:xero_tenant_id) { "XERO_TENANT_ID" }
    let(:access_token) { "access_token" }

    describe "#get" do
      context "with a valid tenant id and access token" do
        it "should return a status of ok" do
          VCR.use_cassette("xpm_ruby/connection/get") do
            connection = Connection.new(access_token: access_token, xero_tenant_id: xero_tenant_id)
            response = connection.get(endpoint: "staff.api/list")

            expect(response["Status"]).to eq("OK")
          end
        end
      end

      context "with an invalid xero_tenant_id" do
        it "should raise an error" do
          VCR.use_cassette("xpm_ruby/connection/get/bad_tenant") do
            connection = Connection.new(access_token: access_token, xero_tenant_id: "bad_tenant")

            expect { connection.get(endpoint: "staff.api/list") }
              .to raise_error(XpmRuby::AuthenticationUnsuccessful, /AuthenticationUnsuccessful/)
          end
        end
      end

      context "when XPM returns another forbidden detail" do
        before(:each) do
          response = instance_double(
            Faraday::Response,
            status: 403,
            body: { Detail: "InsufficientPermissions" }.to_json,
            headers: {}
          )
          allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(response)
        end

        it "raises the generic forbidden error" do
          connection = Connection.new(access_token: access_token, xero_tenant_id: xero_tenant_id)

          expect { connection.get(endpoint: "staff.api/list") }.to raise_error do |error|
            expect(error.class).to eq(XpmRuby::Forbidden)
            expect(error.message).to eq("InsufficientPermissions")
          end
        end
      end

      context "with an invalid access_token" do
        it "should raise an error" do
          VCR.use_cassette("xpm_ruby/connection/get/bad_token") do
            connection = Connection.new(access_token: "bad_token", xero_tenant_id: xero_tenant_id)
            expect { connection.get(endpoint: "staff.api/list") }.to raise_error(XpmRuby::Unauthorized, /AuthenticationUnsuccessful/)
          end
        end
      end

      context "when connection to API failed" do
        before(:each) do
          allow_any_instance_of(Faraday::Connection).to receive(:get).and_raise(Faraday::ConnectionFailed.new("connection failed"))
        end

        it "should raise an error" do
          connection = Connection.new(access_token: "bad_token", xero_tenant_id: xero_tenant_id)
          expect { connection.get(endpoint: "staff.api/list") }.to raise_error(XpmRuby::ConnectionFailed)
        end
      end

      context "when connection to API timeout" do
        before(:each) do
          allow_any_instance_of(Faraday::Connection).to receive(:get).and_raise(Faraday::TimeoutError.new("timeout"))
        end

        it "should raise an error" do
          connection = Connection.new(access_token: "bad_token", xero_tenant_id: xero_tenant_id)
          expect { connection.get(endpoint: "staff.api/list") }.to raise_error(XpmRuby::ConnectionTimeout)
        end
      end

      context "with XPM API is unavailable" do
        it "should raise an error" do
          VCR.use_cassette("xpm_ruby/connection/get/not_available") do
            connection = Connection.new(access_token: "bad_token", xero_tenant_id: xero_tenant_id)
            expect { connection.get(endpoint: "staff.api/list") }.to raise_error(XpmRuby::NotAvailable)
          end
        end
      end

      context "with XPM API returns internal server error" do
        it "should raise an error" do
          VCR.use_cassette("xpm_ruby/connection/get/internal_server_error") do
            connection = Connection.new(access_token: "bad_token", xero_tenant_id: xero_tenant_id)
            expect { connection.get(endpoint: "staff.api/list") }.to raise_error(XpmRuby::InternalServerError)
          end
        end
      end

      context "when API rate limit is exceeded" do
        it "should raise an error with details" do
          VCR.use_cassette("xpm_ruby/connection/get/rate_limit_exceeded") do
            connection = Connection.new(access_token: access_token, xero_tenant_id: xero_tenant_id)
            expect { connection.get(endpoint: "staff.api/list") }.to raise_error(an_instance_of(XpmRuby::RateLimitExceeded).and(having_attributes(details: {
              "retry-after" => "22",
              "x-rate-limit-problem" => "minute",
              "x-minlimit-remaining" => "0",
              "x-daylimit-remaining" => "4539",
              "x-appminlimit-remaining" => "9938"
            })))
          end
        end
      end
    end

    describe "rate limit reporting" do
      let(:reported) { [] }

      let(:xml_body) { "<Response><Status>OK</Status></Response>" }

      let(:rate_limit_headers) do
        {
          "x-rate-limit-problem" => "day",
          "x-minlimit-remaining" => "54",
          "x-daylimit-remaining" => "1200",
          "x-appminlimit-remaining" => "9938"
        }
      end

      before(:each) do
        XpmRuby.on_rate_limits = ->(limits) { reported << limits }
      end

      def stub_response(status:, body:, headers:)
        response = instance_double(Faraday::Response, status: status, body: body, headers: headers)
        allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(response)
      end

      # The reason this gem change exists. A 429 can only ever say the budget is already gone; a
      # caller pacing itself under the limit needs the count while its requests still work.
      context "on a successful response" do
        before(:each) do
          stub_response(status: 200, body: xml_body, headers: rate_limit_headers)
        end

        it "reports the budget Xero returned" do
          connection = Connection.new(access_token: access_token, xero_tenant_id: xero_tenant_id)
          connection.get(endpoint: "staff.api/list")

          expect(reported.size).to eq(1)
          expect(reported.first.to_h).to eq(
            status: 200,
            xero_tenant_id: xero_tenant_id,
            problem: "day",
            retry_after: nil,
            minlimit_remaining: 54,
            daylimit_remaining: 1200,
            appminlimit_remaining: 9938
          )
        end

        it "still returns the parsed response to the caller" do
          connection = Connection.new(access_token: access_token, xero_tenant_id: xero_tenant_id)

          expect(connection.get(endpoint: "staff.api/list")["Status"]).to eq("OK")
        end
      end

      context "when the response names no limit" do
        before(:each) do
          stub_response(status: 200, body: xml_body, headers: { "content-type" => "text/xml" })
        end

        # Reporting an object of nils would make every caller guard against a reading that says
        # nothing, and would look identical to a budget that had run out.
        it "reports nothing" do
          connection = Connection.new(access_token: access_token, xero_tenant_id: xero_tenant_id)
          connection.get(endpoint: "staff.api/list")

          expect(reported).to be_empty
        end
      end

      context "on a refused response" do
        it "reports the refusal and still raises with the details it always carried" do
          VCR.use_cassette("xpm_ruby/connection/get/rate_limit_exceeded") do
            connection = Connection.new(access_token: access_token, xero_tenant_id: xero_tenant_id)

            expect { connection.get(endpoint: "staff.api/list") }.to raise_error(XpmRuby::RateLimitExceeded)
          end

          expect(reported.size).to eq(1)
          expect(reported.first).to have_attributes(
            status: 429,
            problem: "minute",
            retry_after: 22,
            daylimit_remaining: 4539
          )
        end
      end

      context "when the callback raises" do
        before(:each) do
          stub_response(status: 200, body: xml_body, headers: rate_limit_headers)
          XpmRuby.on_rate_limits = ->(_limits) { raise("redis is down") }
        end

        # A hook that only measures a budget must not be able to fail the request it measured.
        it "does not fail the request" do
          connection = Connection.new(access_token: access_token, xero_tenant_id: xero_tenant_id)

          expect { connection.get(endpoint: "staff.api/list") }
            .to output(/XpmRuby.on_rate_limits raised RuntimeError: redis is down/).to_stderr

          expect(connection.get(endpoint: "staff.api/list")["Status"]).to eq("OK")
        end
      end

      context "with no callback set" do
        before(:each) do
          stub_response(status: 200, body: xml_body, headers: rate_limit_headers)
          XpmRuby.on_rate_limits = nil
        end

        it "returns the response as before" do
          connection = Connection.new(access_token: access_token, xero_tenant_id: xero_tenant_id)

          expect(connection.get(endpoint: "staff.api/list")["Status"]).to eq("OK")
        end
      end
    end

    describe "#post" do
      let(:xml_string) do
        "<Job><Name>Brochure Design</Name><Description>Detailed description of the job</Description><ClientID>24097642</ClientID><StartDate>20291023</StartDate><DueDate>20291028</DueDate></Job>"
      end

      context "with a valid tenant id and access token" do
        it "should post to Faraday with the right endpoint, data and headers" do
          VCR.use_cassette("xpm_ruby/connection/post") do
            connection = Connection.new(access_token: access_token, xero_tenant_id: xero_tenant_id)
            response = connection.post(endpoint: "job.api/add", data: xml_string)

            expect(response["Status"]).to eq("OK")
          end
        end
      end

      context "with an invalid xero_tenant_id" do
        it "should raise an error" do
          VCR.use_cassette("xpm_ruby/connection/post/bad_tenant") do
            connection = Connection.new(access_token: access_token, xero_tenant_id: "bad_tenant")

            expect { connection.post(endpoint: "job.api/add", data: xml_string) }
              .to raise_error(XpmRuby::AuthenticationUnsuccessful, /AuthenticationUnsuccessful/)
          end
        end
      end

      context "with an invalid access_token" do
        it "should raise an error" do
          VCR.use_cassette("xpm_ruby/connection/post/bad_token") do
            connection = Connection.new(access_token: "bad_token", xero_tenant_id: xero_tenant_id)
            expect { connection.post(endpoint: "job.api/add", data: xml_string) }.to raise_error(XpmRuby::Unauthorized, /AuthenticationUnsuccessful/)
          end
        end
      end
    end

    describe "#put" do
      let(:xml_string) do
        "<Job><ID>J000029</ID><Name>Brochure Design UPDATED</Name><Description>Detailed description of the job</Description><ClientID>24097642</ClientID><StartDate>20291023</StartDate><DueDate>20291028</DueDate></Job>"
      end

      context "with a valid tenant id and access token" do
        it "should post to Faraday with the right endpoint, data and headers" do
          VCR.use_cassette("xpm_ruby/connection/put") do
            connection = Connection.new(access_token: access_token, xero_tenant_id: xero_tenant_id)
            response = connection.put(endpoint: "job.api/update", data: xml_string)

            expect(response["Status"]).to eq("OK")
          end
        end
      end

      context "with an invalid xero_tenant_id" do
        it "should raise an error" do
          VCR.use_cassette("xpm_ruby/connection/put/bad_tenant") do
            connection = Connection.new(access_token: access_token, xero_tenant_id: "bad_tenant")

            expect { connection.put(endpoint: "job.api/update", data: xml_string) }
              .to raise_error(XpmRuby::AuthenticationUnsuccessful, /AuthenticationUnsuccessful/)
          end
        end
      end

      context "with an invalid access_token" do
        it "should raise an error" do
          VCR.use_cassette("xpm_ruby/connection/put/bad_token") do
            connection = Connection.new(access_token: "bad_token", xero_tenant_id: xero_tenant_id)
            expect { connection.put(endpoint: "job.api/update", data: xml_string) }.to raise_error(XpmRuby::Unauthorized, /AuthenticationUnsuccessful/)
          end
        end
      end
    end

    describe "#delete" do
      let(:contact_id) { "14574323" }

      it "should delete to Faraday with the right endpoint" do
        VCR.use_cassette("xpm_ruby/connection/delete") do
          connection = Connection.new(access_token: access_token, xero_tenant_id: xero_tenant_id)
          response = connection.delete(endpoint: "client.api/contact", id: contact_id)

          expect(response["Status"]).to eq("OK")
        end
      end

      context "with an invalid xero_tenant_id" do
        it "should raise an error" do
          VCR.use_cassette("xpm_ruby/connection/delete/bad_tenant") do
            connection = Connection.new(access_token: access_token, xero_tenant_id: "bad_tenant")

            expect { connection.delete(endpoint: "client.api/contact", id: contact_id) }
              .to raise_error(XpmRuby::AuthenticationUnsuccessful, /AuthenticationUnsuccessful/)
          end
        end
      end

      context "with an invalid access_token" do
        it "should raise an error" do
          VCR.use_cassette("xpm_ruby/connection/delete/bad_token") do
            connection = Connection.new(access_token: "bad_token", xero_tenant_id: xero_tenant_id)
            expect { connection.delete(endpoint: "client.api/contact", id: contact_id) }.to raise_error(XpmRuby::Unauthorized, /AuthenticationUnsuccessful/)
          end
        end
      end
    end
  end
end
