require "spec_helper"

module XpmRuby
  module Client
    RSpec.describe(Contact) do
      describe ".update" do
        let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
        let(:access_token) { "token" }

        let(:contact) do
          {
            "Name" => "Acmer Pty Ltd Updated 3"
          }
        end

        it "updates contact" do
          VCR.use_cassette("xpm_ruby/client/contact/update") do
            updated_contact = Contact.update(
              access_token: access_token,
              xero_tenant_id: xero_tenant_id,
              id: 15412877,
              contact: contact)

            expect(updated_contact["ID"]).not_to be_nil
            expect(updated_contact["Name"]).to eql(updated_contact["Name"])
          end
        end
      end
    end
  end
end
