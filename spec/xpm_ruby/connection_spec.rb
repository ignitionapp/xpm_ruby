require "spec_helper"

module XpmRuby
  RSpec.describe(Connection) do

    let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
    let(:access_token) { "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFDQUY4RTY2NzcyRDZEQzAyOEQ2NzI2RkQwMjYxNTgxNTcwRUZDMTkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJISy1PWm5jdGJjQW8xbkp2MENZVmdWY09fQmsifQ.eyJuYmYiOjE1ODg1NDg0NjAsImV4cCI6MTU4ODU1MDI2MCwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS54ZXJvLmNvbSIsImF1ZCI6Imh0dHBzOi8vaWRlbnRpdHkueGVyby5jb20vcmVzb3VyY2VzIiwiY2xpZW50X2lkIjoiNDkyMjZBNjIzMzY0NDVFM0FGQUM5QTQ4MkJGOUUyN0UiLCJzdWIiOiIwY2FmMWU4MWYyZWE1MzdkYWIxYjYzNTY3NTc2ZDk3ZSIsImF1dGhfdGltZSI6MTU4ODU0ODQ1MSwieGVyb191c2VyaWQiOiJmYzI5MDBjNy0wNjcyLTQzOGItOTNkMS1hOGMyNTBmZDg5MjkiLCJnbG9iYWxfc2Vzc2lvbl9pZCI6IjJjODBmMmNhNmU3OTQyYWNiZTBiYTk1NzY0Nzk1NGFhIiwianRpIjoiZTQ5ZWUxODYzNTMzZGQwNDgxOGU0ODM3NTI2N2RjNDIiLCJzY29wZSI6WyJlbWFpbCIsInByb2ZpbGUiLCJvcGVuaWQiLCJwcmFjdGljZW1hbmFnZXIiLCJvZmZsaW5lX2FjY2VzcyJdfQ.mR6KQeDBi30hNt_turDOgeq9FN3xuJGoaTlcbetP4vRjy-HhkHpUfbWk6oUqU7M1-u_xKwWh2N3saH7xJTbE5T4lnj5FJLLz_GXL3uokhD9Z4TFk7ZjwjrOlg-Y0fvLwYc_DC-BG0m58clYPZnWSBxRtlVvIe7tSEGj0aH5ka9uRpfUTgWznrB-XokRoP2KtHNqY-oP2MqY-qmaX_1tzc3wzYxpAEu8X4anCSqCZan8Qx7q0RvdG8nvnrWWIRNAlZflT3t7oVJR3wNh2QIb85g8i0T92_Fn73zU4p-r7xd0VsWP4npX8DQpBsJNqt03Du3OwiwNyrzS2B6UskYsiEQ" }

    describe "#get" do
      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/connection/get") do
          example.run
        end
      end

      it "should do a get via Faraday" do
        connection = Connection.new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        response = connection.get(endpoint: "staff.api/list")

        expect(response["Status"]).to eq("OK")
      end
    end

    describe "#post" do
      let(:xml_string) do
        "<Job><Name>Brochure Design</Name><Description>Detailed description of the job</Description><ClientID>24097642</ClientID><StartDate>20291023</StartDate><DueDate>20291028</DueDate></Job>"
      end

      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/connection/post") do
          example.run
        end
      end

      it "should post to Faraday with the right endpoint, data and headers" do
        connection = Connection.new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        response = connection.post(endpoint: "job.api/add", data: xml_string)

        expect(response["Status"]).to eq("OK")
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
  end
end
