require "spec_helper"

module XpmRuby
  RSpec.describe(Client) do
    describe ".add" do
    let(:api_key) { "" }
    let(:account_key) { "" }
    let(:api_url) { "api.workflowmax.com" }

    let(:client) do
      Client.build(
        name: "Acmer Pty Ltd",
        email: "someone@example.com",
        address: "1 Address Place",
        city: "Sydney",
        region: "NSW",
        post_code: "2000",
        country: "Australia",
        postal_address: "
          Level 32, PWC Building
          188 Quay Street
          Auckland Central",
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
        account_manager: "",
        contacts: [
          Client::Contact.build(
            name: "Someone else",
            is_primary: true,
            salutation: "MR",
            addressee: "?",
            phone: "02 0000 0000",
            mobile: "0411 0000 0000",
            email: "someone.else@example.com",
            position: "Manager")],
        billing_client_uuid: "",
        first_name: "Someone",
        last_name: "Person",
        date_of_birth: Date.parse("1987/05/11"),
        job_manager_uuid: ""
        tax_number: "11 1111 1111",
        company_number: "02 1000 1000",
        business_number: "02 1000 2000",
        business_structure: "Corporate",
        balance_month: "Jan",
        prepare_gst: false,
        gst_registered: true,
        gst_period: 6,
        gst_basis: "Invoice",
        provisional_tax_basis: Client::ProvisionalTaxBasis::STANDARD,
        provisional_tax_ratio: "1",
        signed_tax_authority: true,
        tax_agent: "Mr Tax Agent",
        agency_status: Client::AgencyStatus::WITH_EOT,
        return_type: Client::ReturnType::IR3,
        prepare_activity_statement: true,
        prepare_tax_return: true)
    end

    it "adds client" do
      expect(
        Client.add(api_key: api_key, account_key: account_key, api_url: api_url)
      ).to include(client)
    end
  end
end
