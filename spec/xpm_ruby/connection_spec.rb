require "spec_helper"

module XpmRuby
  RSpec.describe(Connection) do
    let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
    let(:access_token) { "accepted" }

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
  end
end
