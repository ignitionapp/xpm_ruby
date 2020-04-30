require "spec_helper"

module XpmRuby
  RSpec.describe(Connection) do
    subject(:service) { described_class }

    let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }

    describe "#get" do
      context "when access token rejected" do
        let(:access_token) { "invalid" }

        it "raises access token expired exception" do
          VCR.use_cassette("xpm_ruby/connection/get/access_token_rejected") do
            expect do
              Connection
                .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
                .get(endpoint: "staff.api/list")
            end.to raise_error(XpmRuby::AccessTokenRejected)
          end
        end
      end

      context "when access token expired" do
        let(:access_token) { "expired" }

        it "raises access token expired exception" do
          VCR.use_cassette("xpm_ruby/connection/get/access_token_expired") do
            expect do
              Connection
                .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
                .get(endpoint: "staff.api/list")
            end.to raise_error(XpmRuby::AccessTokenExpired)
          end
        end
      end

      context "valid access token" do
        let(:access_token) { "" }

        it "should do a get via Faraday" do
          VCR.use_cassette("xpm_ruby/connection/get") do
            connection = service.new(access_token: access_token, xero_tenant_id: xero_tenant_id)
            response = connection.get(endpoint: "staff.api/list")

            expect(response["Status"]).to eq("OK")
          end
        end
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

        expect(response["Status"]).to eq("OK")
      end
    end
  end
end
