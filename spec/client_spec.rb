require "spec_helper"

module XpmRuby
  RSpec.describe(Client) do
    describe ".add" do
      context "when keys invalid" do
        let(:api_key) { "" }
        let(:account_key) { "" }

        xit "raises unauthorized error" do
          expect do
            client.list(api_key: api_key, account_key: account_key)
          end.to raise_error(Client::Unauthorized)
        end
      end

      context "when keys valid" do
        let(:api_key) { "" }
        let(:account_key) { "" }

        xit "adds client" do
          expect(
            Client.add(api_key: api_key, account_key: account_key)
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
