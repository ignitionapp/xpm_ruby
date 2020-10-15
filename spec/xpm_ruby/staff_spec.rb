require "spec_helper"

module XpmRuby
  RSpec.describe(Staff) do
    describe ".list" do
      let(:xero_tenant_id) { "XERO_TENANT_ID" }

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

      context "when access token unauthorized" do
        let(:access_token) { "unauthorized" }

        it "raises access token expired exception" do
          VCR.use_cassette("xpm_ruby/staff/list/access_token_unauthorized") do
            expect do
              Staff.list(access_token: access_token, xero_tenant_id: xero_tenant_id)
            end.to raise_error(XpmRuby::Unauthorized)
          end
        end
      end

      context "when access token accepted" do
        let(:access_token) { "accepted" }

        context "when multiple Staff returned" do
          it "lists staff", :aggregate_failure do
            VCR.use_cassette("xpm_ruby/staff/list/access_token_accepted") do
              staff_list = Staff.list(access_token: access_token, xero_tenant_id: xero_tenant_id)

              staff = staff_list.last

              expect(staff["Name"]).to eql("test")
              expect(staff["Email"]).to eql("adammikulas@gmail.com")
              # expect(staff.uuid).to eql("1cc99c1e-8cf7-4248-ab84-3e11126facbc")
            end
          end
        end

        context "when a single Staff is returned" do
          it "returns an Array of Staff", :aggregate_failure do
            VCR.use_cassette("xpm_ruby/staff/list/access_token_accepted_one_staff") do
              staff_list = Staff.list(access_token: access_token, xero_tenant_id: xero_tenant_id)

              expect(staff_list).to be_a(Array)
              expect(staff_list.first["Name"]).to eql("Adam Silver")
            end
          end
        end
      end
    end
  end
end
