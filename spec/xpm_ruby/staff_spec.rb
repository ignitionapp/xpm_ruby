require "spec_helper"

module XpmRuby
  RSpec.describe(Staff) do
    subject(:service) { described_class }

    describe ".list" do
      context "when keys invalid" do
        let(:api_key) { "" }
        let(:account_key) { "" }
        let(:api_url) { "api.workflowmax.com" }

        xit "raises unauthorized error" do
          expect do
            Staff.list(api_key: api_key, account_key: account_key, api_url: api_url)
          end.to raise_error(Unauthorized)
        end
      end

      context "when keys valid" do
        let(:xero_tenant_id) { "XERO_TENANT_ID" }
        let(:access_token) { "XERO_ACCESS_TOKEN" }

        around(:each) do |example|
          VCR.use_cassette("xpm_ruby/staff/list") do
            example.run
          end
        end

        it "lists staff" do
          staff_list = service.list(access_token: access_token, xero_tenant_id: xero_tenant_id)

          staff = staff_list.last

          expect(staff["Name"]).to eql("test")
          expect(staff["Email"]).to eql("adammikulas@gmail.com")
          # expect(staff.uuid).to eql("1cc99c1e-8cf7-4248-ab84-3e11126facbc")
        end
      end
    end
  end
end
