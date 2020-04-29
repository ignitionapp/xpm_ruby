require "spec_helper"

module XpmRuby
  RSpec.describe(Client) do
    around(:each) do |example|
      VCR.use_cassette("xpm_ruby/client/add") do
        example.run
      end
    end

    describe ".add" do
      let(:xero_tenant_id) { "XERO_TENANT_ID" }
      let(:access_token) { "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFDQUY4RTY2NzcyRDZEQzAyOEQ2NzI2RkQwMjYxNTgxNTcwRUZDMTkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJISy1PWm5jdGJjQW8xbkp2MENZVmdWY09fQmsifQ.eyJuYmYiOjE1ODgxMjI5NjIsImV4cCI6MTU4ODEyNDc2MiwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS54ZXJvLmNvbSIsImF1ZCI6Imh0dHBzOi8vaWRlbnRpdHkueGVyby5jb20vcmVzb3VyY2VzIiwiY2xpZW50X2lkIjoiNDkyMjZBNjIzMzY0NDVFM0FGQUM5QTQ4MkJGOUUyN0UiLCJzdWIiOiIwY2FmMWU4MWYyZWE1MzdkYWIxYjYzNTY3NTc2ZDk3ZSIsImF1dGhfdGltZSI6MTU4ODEyMjk1NCwieGVyb191c2VyaWQiOiJmYzI5MDBjNy0wNjcyLTQzOGItOTNkMS1hOGMyNTBmZDg5MjkiLCJnbG9iYWxfc2Vzc2lvbl9pZCI6ImMyMGI5NTg2NzA2MzQ0MTZiZmFmYjQ3YWY3NzY2NmE3IiwianRpIjoiMGM3OWM5ZGYwZjY0YmFiMzkyNmM0MzdkOWVhZDI2ZWIiLCJzY29wZSI6WyJlbWFpbCIsInByb2ZpbGUiLCJvcGVuaWQiLCJwcmFjdGljZW1hbmFnZXIiLCJvZmZsaW5lX2FjY2VzcyJdfQ.LRa5A9ZgTx8wdYSkD79KVkXmPG_hSclxQZ6PJJtRHHsEf8bnuL0awxzeTLjVCWh-tfYsA7nJv0fWDJwtqbZOeRA6qVR6QxLGE8-LYBnPDi2BcOcvUfSlBcQtpJP8Imf0hBl_luvkPVazi8ZYcEX4dgdLFBYdaXDijF-2kQEoJAXkWaLK0TWQbT9sWpfRzK0sPUU2Y9bws3A3GqGmjmP5s6B92wM06JBHfbjL2O3yIKK_2f47jag6wS-gmboBy0Zhv8wiN_nLSum7R26U6EmESLza4o-LzG8WQYSoUVet5mR0PxkGtSG5mOT3IYd9xKfmipTpdoKQAaKfqFC_dyexiA" }

      let(:client) do
        Client.build(
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
            Client::Contact.build(
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
        created_client = Client.add(
          access_token: access_token,
          xero_tenant_id: xero_tenant_id,
          client: client)

        # expect(created_client.uuid).not_to be_nil
        expect(created_client.name).to eql(client.name)
      end
    end
  end
end
