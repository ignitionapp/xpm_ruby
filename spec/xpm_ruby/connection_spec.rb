require "spec_helper"

module XpmRuby
  RSpec.describe(Connection) do
    subject(:service) { described_class }

    let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
    let(:access_token) { "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFDQUY4RTY2NzcyRDZEQzAyOEQ2NzI2RkQwMjYxNTgxNTcwRUZDMTkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJISy1PWm5jdGJjQW8xbkp2MENZVmdWY09fQmsifQ.eyJuYmYiOjE1ODgxMTUyMTQsImV4cCI6MTU4ODExNzAxNCwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS54ZXJvLmNvbSIsImF1ZCI6Imh0dHBzOi8vaWRlbnRpdHkueGVyby5jb20vcmVzb3VyY2VzIiwiY2xpZW50X2lkIjoiNDkyMjZBNjIzMzY0NDVFM0FGQUM5QTQ4MkJGOUUyN0UiLCJzdWIiOiIwY2FmMWU4MWYyZWE1MzdkYWIxYjYzNTY3NTc2ZDk3ZSIsImF1dGhfdGltZSI6MTU4ODA1MTE0MywieGVyb191c2VyaWQiOiJmYzI5MDBjNy0wNjcyLTQzOGItOTNkMS1hOGMyNTBmZDg5MjkiLCJnbG9iYWxfc2Vzc2lvbl9pZCI6IjQzMGI0ZmVmMWI0NjQ2MGZiMTgwOWNmNmQ5OWJhODIxIiwianRpIjoiMmI3NGQxZDZhMzcxNDlhN2VjNjkwNmM2NGM0MDFlMjEiLCJzY29wZSI6WyJlbWFpbCIsInByb2ZpbGUiLCJvcGVuaWQiLCJwcmFjdGljZW1hbmFnZXIiLCJvZmZsaW5lX2FjY2VzcyJdfQ.EJ5_dU4efS9e2w68A63GQaVWghmcIONEOfkB4Wp0IGNwTbNU441x3vSAMdRY5MShT1jk9cTR-207OKClFJAuwWZbODQcs2bV9YDj5PH9cCtNCULFOClQCn7zfUonkMdZ9FiL4RjJ6xXbWOmfD-vYhQRLbAkKDcZad8HcPIzPyKvyHFuxTDk7FKs-OI3sUPQUqQrBKAcmD2C8PR8al7PNn0kwrug1a2_R0z74Sygg1iKJlShMLMBbaDfq_7zxbMvGrLvW1vLMlJDhxD-sR4_T-B3n6_VDFybFfShQqtkoJwk4-fAqc0S8N0Vmx_kRLqzVEIE8NiouqnTvt6i8Bvc5PQ" }

    describe "#get" do
      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/connection/get") do
          example.run
        end
      end

      it "should do a get via Faraday" do
        connection = service.new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        response = connection.get(endpoint: "staff.api/list")

        hash = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        expect(hash["Response"]["Status"]).to eq("OK")
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
        connection = service.new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        response = connection.post(endpoint: "job.api/add", data: xml_string)

        hash = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        expect(hash["Response"]["Status"]).to eq("OK")
      end
    end
  end
end
