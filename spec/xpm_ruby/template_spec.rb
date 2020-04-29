require "spec_helper"

module XpmRuby
  RSpec.describe(Template) do
    subject(:service) { described_class }

    describe ".list" do
      let(:xero_tenant_id) { "XERO_TENANT_ID" }
      let(:access_token) { "XERO_ACCESS_TOKEN" }

      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/template/list") do
          example.run
        end
      end

      it "lists templates" do
        template_list = service.list(access_token: access_token, xero_tenant_id: xero_tenant_id)

        expect(template_list.length).to eq(11)

        template = template_list.first

        expect(template.name).to eql("Activity Statement")
        # expect(template.uuid).to eql("d5dd52a0-edc1-4b03-94e7-931aa34ab35c")
      end
    end
  end
end
