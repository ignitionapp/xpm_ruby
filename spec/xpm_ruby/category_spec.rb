require "spec_helper"

module XpmRuby
  RSpec.describe(Category) do
    subject(:service) { described_class }

    describe ".list" do
      let(:xero_tenant_id) { "XERO_TENANT_ID" }
      let(:access_token) { "access_token" }

      context "when API returns an array of categories" do
        around(:each) do |example|
          VCR.use_cassette("xpm_ruby/category/list") do
            example.run
          end
        end

        it "lists categories" do
          categories_list = service.list(access_token: access_token, xero_tenant_id: xero_tenant_id)

          expect(categories_list.length).to eq(3)

          category = categories_list.first

          expect(category["Name"]).to eql("Compliance")
          expect(category["ID"]).to eql("304252")
        end
      end

      context "when API doesn't return an array" do
        around(:each) do |example|
          VCR.use_cassette("xpm_ruby/category/list_empty_array") do
            example.run
          end
        end

        it "returns an empty array" do
          categories_list = service.list(access_token: access_token, xero_tenant_id: xero_tenant_id)

          expect(categories_list).to eq([])
        end
      end
    end
  end
end
