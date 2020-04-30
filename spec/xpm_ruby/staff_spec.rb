require "spec_helper"

module XpmRuby
  RSpec.describe(Staff) do
    describe ".list" do
      let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }

      context "when access token expired" do
        let(:access_token) { "expired" }

        it "raises access token expired exception" do
          VCR.use_cassette("xpm_ruby/staff/list/access_token_expired") do
            expect do
              Connection
                .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
                .get(endpoint: "staff.api/list")
            end.to raise_error(XpmRuby::AccessTokenExpired)
          end
        end
      end

      context "when access token rejected" do
        let(:access_token) { "rejected" }

        it "raises access token expired exception" do
          VCR.use_cassette("xpm_ruby/staff/list/access_token_rejected") do
            expect do
              Staff.list(access_token: access_token, xero_tenant_id: xero_tenant_id)
            end.to raise_error(XpmRuby::AccessTokenRejected)
          end
        end
      end

      context "when access token accepted" do
        let(:access_token) { "accepted" }

        it "lists staff" do
          VCR.use_cassette("xpm_ruby/staff/list/access_token_accepted") do
            staff_list = Staff.list(access_token: access_token, xero_tenant_id: xero_tenant_id)

            staff = staff_list.last

            expect(staff["Name"]).to eql("test")
            expect(staff["Email"]).to eql("adammikulas@gmail.com")
            # expect(staff.uuid).to eql("1cc99c1e-8cf7-4248-ab84-3e11126facbc")
          end
        end
      end
    end
  end
end
