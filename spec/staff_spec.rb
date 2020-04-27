require "spec_helper"

module XpmRuby
  RSpec.describe(Staff) do
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
        let(:api_key) { "" }
        let(:account_key) { "" }
        let(:api_url) { "api.workflowmax.com" }

        xit "lists staff" do
          expect(
            Staff.list(api_key: api_key, account_key: account_key, api_url: api_url)
          ).to include(
            Staff.build(
              name: "Dev Testing",
              email: "dev@practiceignition.com",
              uuid: "8c79202e-caf8-4a12-a3d7-ac338e50741f"))
        end
      end
    end
  end
end
