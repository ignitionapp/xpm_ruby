require "spec_helper"

module XpmRuby
  RSpec.describe(Connection) do
    let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
    let(:access_token) { "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFDQUY4RTY2NzcyRDZEQzAyOEQ2NzI2RkQwMjYxNTgxNTcwRUZDMTkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJISy1PWm5jdGJjQW8xbkp2MENZVmdWY09fQmsifQ.eyJuYmYiOjE1ODg2NTA2MjEsImV4cCI6MTU4ODY1MjQyMSwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS54ZXJvLmNvbSIsImF1ZCI6Imh0dHBzOi8vaWRlbnRpdHkueGVyby5jb20vcmVzb3VyY2VzIiwiY2xpZW50X2lkIjoiNDkyMjZBNjIzMzY0NDVFM0FGQUM5QTQ4MkJGOUUyN0UiLCJzdWIiOiIwY2FmMWU4MWYyZWE1MzdkYWIxYjYzNTY3NTc2ZDk3ZSIsImF1dGhfdGltZSI6MTU4ODY1MDYwOSwieGVyb191c2VyaWQiOiJmYzI5MDBjNy0wNjcyLTQzOGItOTNkMS1hOGMyNTBmZDg5MjkiLCJnbG9iYWxfc2Vzc2lvbl9pZCI6IjJjODE3OTIzZWI3NTQ5Nzk4ODZkNmQyNzNlMDIxOWY4IiwianRpIjoiNGM0NmJmZDA5NjFlYWZhNmFmZjQ1M2M1NjQ0NWEyZGEiLCJzY29wZSI6WyJlbWFpbCIsInByb2ZpbGUiLCJvcGVuaWQiLCJwcmFjdGljZW1hbmFnZXIiLCJvZmZsaW5lX2FjY2VzcyJdfQ.Zsak1BIzRocLPjWb62uVgNaWO3U3o1LKtWrzO2Sj3AoSg-y1Rk5bKxp9PzaAEtE2qmyMQTDGlPHV0jzcqnZOqbbWdLAqyLVDQEeW7nh-9ZWVHmuJ9GG7DKzvHv7Sau_R3i_TlRRcdnQmYdhvZlqg-eUeZXGdzJnFWDk121SuV3dMJV0fJsfg3sfdr7DmbBoWCn-hdcSo2CuYA-IdnIFvlaX2lfZ06i391kYF0YGbWcZ_BX6cUWKMYBuoT_dBZL0wN_6q5KLCgRrLFqgXoR8Eao-h6bXEPTHgx0rW14cVeSrVOeobmJjqnsEd2LyDyn5zWaoie2Xezt5KBtNPtPGr7g" }

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

            expect { connection.get(endpoint: "staff.api/list") }.to raise_error(XpmRuby::Unauthorized, /AuthenticationUnsuccessful/)
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

            expect { connection.post(endpoint: "job.api/add", data: xml_string) }.to raise_error(XpmRuby::Unauthorized, /AuthenticationUnsuccessful/)
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

      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/connection/put") do
          example.run
        end
      end

      it "should post to Faraday with the right endpoint, data and headers" do
        connection = Connection.new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        response = connection.put(endpoint: "job.api/update", data: xml_string)

        expect(response["Status"]).to eq("OK")
      end
    end

    describe "#delete" do
      let(:contact_id) { "14574323" }

      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/connection/delete") do
          example.run
        end
      end

      it "should delete to Faraday with the right endpoint" do
        connection = Connection.new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        response = connection.delete(endpoint: "client.api/contact", id: contact_id)

        expect(response["Status"]).to eq("OK")
      end
    end
  end
end
