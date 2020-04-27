require "spec_helper"

module XpmRuby
  RSpec.describe(Template) do
    subject(:service) { described_class }

    describe ".list" do
      let(:api_key) { "TEST" }
      let(:account_key) { "TEST" }
      let(:api_url) { "api.workflowmax.com" }

      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/template/list") do
          example.run
        end
      end

      it "lists templates" do
        template_list = service.list(api_key: api_key, account_key: account_key, api_url: api_url)

        expect(template_list.length).to eq(11)

        template = template_list.first

        expect(template.name).to eql("Activity Statement")
        expect(template.uuid).to eql("d5dd52a0-edc1-4b03-94e7-931aa34ab35c")
      end
    end
  end
end
