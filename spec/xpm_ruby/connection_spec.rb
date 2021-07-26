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

            expect { connection.get(endpoint: "staff.api/list") }.to raise_error(XpmRuby::Forbidden, /AuthenticationUnsuccessful/)
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

            expect { connection.post(endpoint: "job.api/add", data: xml_string) }.to raise_error(XpmRuby::Forbidden, /AuthenticationUnsuccessful/)
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

            expect { connection.put(endpoint: "job.api/update", data: xml_string) }.to raise_error(XpmRuby::Forbidden, /AuthenticationUnsuccessful/)
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

            expect { connection.delete(endpoint: "client.api/contact", id: contact_id) }.to raise_error(XpmRuby::Forbidden, /AuthenticationUnsuccessful/)
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
