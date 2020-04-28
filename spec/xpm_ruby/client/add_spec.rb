require "spec_helper"

module XpmRuby
  module Client
    RSpec.describe(Add) do
      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/client/add") do
          example.run
        end
      end

      describe ".call" do
        let(:api_key) { "" }
        let(:account_key) { "" }
        let(:api_url) { "api.workflowmax.com" }

        let(:client) do
          Client::Add::Client.new(
            name: "Acmer Pty Ltd",
            email: "someone@example.com",
            address: "1 Address Place",
            city: "Sydney",
            region: "NSW",
            post_code: "2000",
            country: "Australia",
            postal_address: "Level 32, PWC Building\n188 Quay Street\nAuckland Central",
            postal_city: "Auckland",
            postal_region: "North Island",
            postal_post_code: "1001",
            postal_country: "New Zealand",
            phone: "00 0000 0000",
            fax: "00 1000 0000",
            web_site: "http://example.com",
            referral_source: "referrer",
            export_code: "EXPORT_CODE",
            is_prospect: false,
            account_manager_uuid: nil,
            contacts: [
              Client::Add::Client::Contact.new(
                name: "Someone else",
                is_primary: true,
                salutation: "MR",
                addressee: "Addressee",
                phone: "02 0000 0000",
                mobile: "0411 0000 0000",
                email: "someone.else@example.com",
                position: "Manager")],
            billing_client_uuid: nil,
            first_name: "Someone",
            last_name: "Person",
            date_of_birth: Date.parse("1987/05/11"),
            job_manager_uuid: nil,
            tax_number: "11 1111 1111",
            company_number: "02 1000 1000",
            business_number: "02 1000 2000",
            business_structure: "Corporate",
            balance_month: "Jan",
            prepare_gst: false,
            gst_registered: true,
            gst_period: Client::GstPeriod::ONE,
            gst_basis: Client::GstBasis::INVOICE,
            provisional_tax_basis: Client::ProvisionalTaxBasis::STANDARD_OPTION,
            provisional_tax_ratio: "1",
            signed_tax_authority: true,
            tax_agent: "Mr Tax Agent",
            agency_status: Client::AgencyStatus::WITH_EOT,
            return_type: Client::ReturnType::IR3,
            prepare_activity_statement: true,
            prepare_tax_return: true)
        end

        it "adds client" do
          created_client = Client::Add.call(
            api_key: api_key,
            account_key: account_key,
            api_url: api_url,
            client: client)

          expect(created_client.uuid).not_to be_nil
          expect(created_client.name).to eql(client.name)
        end
      end
    end
  end
end
