require "spec_helper"

module XpmRuby
  module Client
    RSpec.describe(Contact) do
      describe ".add" do
        let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
        let(:access_token) { "token" }

        let(:contact) do
          {
            "Client" => { "ID" => 25655881 },
            "Name" => "Acmer Pty Ltd"
          }
        end

        it "adds contact" do
          VCR.use_cassette("xpm_ruby/client/contact/add") do
            created_contact = Contact.add(
              access_token: access_token,
              xero_tenant_id: xero_tenant_id,
              contact: contact)

            expect(created_contact["ID"]).not_to be_nil
            expect(created_contact["Name"]).to eql(created_contact["Name"])
          end
        end
      end
    end
  end
end
