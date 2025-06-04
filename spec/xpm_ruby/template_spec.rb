require "spec_helper"

module XpmRuby
  RSpec.describe(Template) do
    subject(:service) { described_class }

    describe ".list" do
      let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
      let(:access_token) { "a_dummy_secret_token" }

      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/template/list") do
          example.run
        end
      end

      it "lists templates" do
        template_list = service.list(access_token: access_token, xero_tenant_id: xero_tenant_id)

        expect(template_list.length).to eq(11)

        template = template_list.first

        expect(template["Name"]).to eql("Activity Statement")
        expect(template["ID"]).to eql("1254074")
      end
    end
  end
end
