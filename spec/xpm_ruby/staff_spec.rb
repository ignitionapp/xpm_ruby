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

    describe ".add" do
      let(:xero_tenant_id) { "xero_tenant_id" }
      let(:access_token) { "access_token" }
      let(:staff) { { "Name" => "Joe Bloggs", "Address" => "In your head", "Phone" => "123456789", "Email" => "joebloggs@foo.com", "PayrollCode" => "PC123" } }

      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/staff/add") do
          example.run
        end
      end

      it "adds a staff" do
        added_staff = Staff.add(access_token: access_token, xero_tenant_id: xero_tenant_id, staff: staff)

        expect(added_staff["Name"]).to eql(staff["Name"])
        expect(added_staff["Address"]).to eql(staff["Address"])
        expect(added_staff["Phone"]).to eql(staff["Phone"])
        expect(added_staff["Email"]).to eql(staff["Email"])
        expect(added_staff["PayrollCode"]).to eql(staff["PayrollCode"])
      end
    end

    describe ".update" do
      let(:xero_tenant_id) { "xero_tenant_id" }
      let(:access_token) { "access_token" }
      let(:staff) { { "ID" => "1044994", "Name" => "Joe Bloggs", "Address" => "Updated Address", "Phone" => "87654321", "Email" => "bloggsjoe@foo.com", "PayrollCode" => "PC456" } }

      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/staff/update") do
          example.run
        end
      end

      it "updates a staff" do
        updated_staff = Staff.update(access_token: access_token, xero_tenant_id: xero_tenant_id, staff: staff)

        expect(updated_staff["ID"]).to eql(staff["ID"])
        expect(updated_staff["Name"]).to eql(staff["Name"])
        expect(updated_staff["Address"]).to eql(staff["Address"])
        expect(updated_staff["Phone"]).to eql(staff["Phone"])
        expect(updated_staff["Email"]).to eql(staff["Email"])
        expect(updated_staff["PayrollCode"]).to eql(staff["PayrollCode"])
      end
    end

    describe ".delete" do
      let(:xero_tenant_id) { "xero_tenant_id" }
      let(:access_token) { "access_token" }

      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/staff/delete") do
          example.run
        end
      end

      it "deletes a staff" do
        deleted_staff = Staff.delete(access_token: access_token, xero_tenant_id: xero_tenant_id, id: "859318")

        expect(deleted_staff).to be(true)
      end
    end
  end
end
