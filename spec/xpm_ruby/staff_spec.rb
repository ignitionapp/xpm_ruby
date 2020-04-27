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
        let(:api_key) { "TEST" }
        let(:account_key) { "TEST" }
        let(:api_url) { "api.workflowmax.com" }

        around(:each) do |example|
          VCR.use_cassette("xpm_ruby/staff/list") do
            example.run
          end
        end

        it "lists staff" do
          connection = XpmRuby::Connection.new(api_key: api_key, account_key: account_key, api_url: api_url)
          staff_list = service.list(connection: connection)

          staff = staff_list.last

          expect(staff.name).to eql("John Doe")
          expect(staff.email).to eql("john@test.com")
          expect(staff.uuid).to eql("1cc99c1e-8cf7-4248-ab84-3e11126facbc")
        end
      end
    end
  end
end
