require "spec_helper"

module XpmRuby
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
        VCR.use_cassette("xpm_ruby/contact/add") do
          created_contact = Contact.add(
            access_token: access_token,
            xero_tenant_id: xero_tenant_id,
            contact: contact)

          expect(created_contact["ID"]).not_to be_nil
          expect(created_contact["Name"]).to eql(created_contact["Name"])
        end
      end
    end

    describe ".update" do
      let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
      let(:access_token) { "token" }

      
      context "without Client ID" do
        let(:contact) do
          {
            "Name" => "Acmer Pty Ltd Updated 3"
          }
        end

        it "updates contact" do
          VCR.use_cassette("xpm_ruby/contact/update") do
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

      context "with Client ID" do
        let(:contact) do
          {
            "Client" => { "ID" => 25655881 },
            "Name" => "Acmer Pty Ltd Updated 3"
          }
        end

        it "updates contact" do
          VCR.use_cassette("xpm_ruby/contact/update") do
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

    describe ".delete" do
      let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
      let(:access_token) { "token" }
      let(:contact_id) { "14574323" }

      it "deletes the contact" do
        VCR.use_cassette("xpm_ruby/contact/delete") do
          deleted_contact = Contact.delete(
            access_token: access_token,
            xero_tenant_id: xero_tenant_id,
            contact_id: contact_id)

          expect(deleted_contact["ID"]).to eql(contact_id)
          expect(deleted_contact["Name"]).to eql("some guy person")
        end
      end
    end
  end
end
