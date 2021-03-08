require "spec_helper"

module XpmRuby
  RSpec.describe(Category) do
    subject(:service) { described_class }

    describe ".list" do
      let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
      let(:access_token) { "access_token" }

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
  end
end
