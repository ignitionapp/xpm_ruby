require "spec_helper"

module XpmRuby
  RSpec.describe(Client) do
    describe ".add" do
      context "when keys invalid" do
        let(:api_key) { "" }
        let(:account_key) { "" }

        xit "raises unauthorized error" do
          expect do
            client.add(api_key: api_key, account_key: account_key)
          end.to raise_error(Unauthorized)
        end
      end

      context "when keys valid" do
        let(:api_key) { "" }
        let(:account_key) { "" }
        let(:client) do
          Client.build(
            name: "Accounting Pty Ltd",
            email: "hello@accounting.com",
            address: "1 Address Place",
            city: "Sydney",
            region: "NSW",
            post_code: "2000",
            country: "Australia",
            postal_address: "1 Postal Address",
            postal_city: "Melbourne",
            postal_region: "VIC",
            postal_post_code: "3000",
            postal_country: "Australia",
            account_manager_uuid: "",
            contacts: [
              Client::Contact.build(
                name: "Adam",
                is_primary: false,
                salutation: "MR",
                addresse: "?",
                phone:
              ))
        end

        xit "adds client" do
          Client.add(api_key: api_key, account_key: account_key, client: client)

          expect(
            Client.list(api_key: api_key, account_key: account_key)
          ).to include(client)
        end
      end
    end
  end
end
