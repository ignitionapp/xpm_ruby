require "spec_helper"

module XpmRuby
  RSpec.describe(Connection) do
    let(:xero_tenant_id) { "XERO_TENANT_ID" }
    let(:access_token) { "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFDQUY4RTY2NzcyRDZEQzAyOEQ2NzI2RkQwMjYxNTgxNTcwRUZDMTkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJISy1PWm5jdGJjQW8xbkp2MENZVmdWY09fQmsifQ.eyJuYmYiOjE1ODg1NjM4MjIsImV4cCI6MTU4ODU2NTYyMiwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS54ZXJvLmNvbSIsImF1ZCI6Imh0dHBzOi8vaWRlbnRpdHkueGVyby5jb20vcmVzb3VyY2VzIiwiY2xpZW50X2lkIjoiNDkyMjZBNjIzMzY0NDVFM0FGQUM5QTQ4MkJGOUUyN0UiLCJzdWIiOiIwY2FmMWU4MWYyZWE1MzdkYWIxYjYzNTY3NTc2ZDk3ZSIsImF1dGhfdGltZSI6MTU4ODU2MzgxNCwieGVyb191c2VyaWQiOiJmYzI5MDBjNy0wNjcyLTQzOGItOTNkMS1hOGMyNTBmZDg5MjkiLCJnbG9iYWxfc2Vzc2lvbl9pZCI6IjQ0ODY2YjJkNmMzNzRiYWZhMzM4MjU0YTFhZjIzNDBhIiwianRpIjoiODBjNDMyNzdhYWM5MzVjMzljYTViYjA2ZjE5OWE1OTIiLCJzY29wZSI6WyJlbWFpbCIsInByb2ZpbGUiLCJvcGVuaWQiLCJwcmFjdGljZW1hbmFnZXIiLCJvZmZsaW5lX2FjY2VzcyJdfQ.fefoKqd3tRoLYlL4Vm9BvfI90ngJ548hzt_Me8_QsJfj_JLU2jRCqXITszpPUDEMWY1rmi3Qgmkgp2rdOdVJlNMYBk_nolPOrxYVSx6H2rMEWSGsMAkDpTuxdzPzuHYQGK5A1u5zHSRJYsHL6Ke-W7XkTv61gcTLoTqbRXRZ6HTvFdHCCKFN89ru0UHzWBi8a2IsVsq0HJOU00mWxK2Gdja1IWlxapWSKpfe16VTZIf7P1ch2HUZg6F2uytxzhYEubh-HYBJtfOnM15F7iWYcdEW9wXP_TtPBkoVFbXnb_J7BXDq5L8nnbKfmxM7Ra23kEvp_kogTwa5m4yEQFzwLQ" }

    describe "#get" do
      it "should do a get via Faraday" do
        VCR.use_cassette("xpm_ruby/connection/get") do
          connection = Connection.new(access_token: access_token, xero_tenant_id: xero_tenant_id)
          response = connection.get(endpoint: "staff.api/list")

          expect(response["Status"]).to eq("OK")
        end
      end
    end

    describe "#post" do
      let(:xml_string) do
        "<Job><Name>Brochure Design</Name><Description>Detailed description of the job</Description><ClientID>24097642</ClientID><StartDate>20291023</StartDate><DueDate>20291028</DueDate></Job>"
      end

      it "should post to Faraday with the right endpoint, data and headers" do
        VCR.use_cassette("xpm_ruby/connection/post") do
          connection = Connection.new(access_token: access_token, xero_tenant_id: xero_tenant_id)
          response = connection.post(endpoint: "job.api/add", data: xml_string)

          expect(response["Status"]).to eq("OK")
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
