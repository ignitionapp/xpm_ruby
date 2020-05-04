require "spec_helper"

module XpmRuby
  RSpec.describe(Client) do
    describe ".add" do
      let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
      let(:access_token) { "token" }

      let(:client) { { "Name" => "Acmer Pty Ltd" } }

      it "adds client" do
        VCR.use_cassette("xpm_ruby/client/add") do
          created_client = Client.add(
            access_token: access_token,
            xero_tenant_id: xero_tenant_id,
            client: client)

          expect(created_client["ID"]).not_to be_nil
          expect(created_client["Name"]).to eql(client["Name"])
        end
      end
    end

    describe ".update" do
      let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
      let(:access_token) { "access_token" }

      let(:client) { { "ID" => 25655881, "Name" => "Acmer Pty Ltd" } }

      it "updates client" do
        VCR.use_cassette("xpm_ruby/client/update") do
          updated_client = Client.update(
            access_token: access_token,
            xero_tenant_id: xero_tenant_id,
            client: client)

          expect(updated_client["ID"]).not_to be_nil
          expect(updated_client["Name"]).to eql(client["Name"])
        end
      end

      describe ".list" do
        let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
        let(:access_token) { "token" }

        it "list client" do
          VCR.use_cassette("xpm_ruby/client/list") do
            clients = Client.list(
              access_token: access_token,
              xero_tenant_id: xero_tenant_id)

            expect(clients.count).to eql(12)
          end
        end
      end
    end
  end
end
