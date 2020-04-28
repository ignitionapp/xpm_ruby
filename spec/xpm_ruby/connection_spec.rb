require "spec_helper"

module XpmRuby
  RSpec.describe(Connection) do
    subject(:service) { described_class }

    let(:api_url) { "api.workflowmax.com" }
    let(:api_key) { "test" }
    let(:account_key) { "test" }

    describe "#initialize" do
      it "should set the basic auth" do
        connection = service.new(api_key: api_key, api_url: api_url, account_key: account_key)
        expect(connection.basic_auth).to eq("Basic dGVzdDp0ZXN0")
      end
    end

    describe "#get" do
      let(:faraday_connection) { instance_double("Faraday::Connection", get: nil) }

      it "should do a get via Faraday" do
        connection = service.new(api_key: api_key, api_url: api_url, account_key: account_key)

        expect(Faraday).to receive(:new).with("https://api.workflowmax.com/v3/staff.api/list", headers: { "Authorization" => "Basic dGVzdDp0ZXN0" }).and_return(faraday_connection)

        connection.get(endpoint: "staff.api/list")
      end
    end

    describe "#post" do
      let(:api_key) { "TEST" }
      let(:account_key) { "TEST" }
      let(:api_url) { "api.workflowmax.com" }

      let(:xml_string) do
        "<Job><Name>Brochure Design</Name><Description>Detailed description of the job</Description><ClientUUID>e349fc1b-d92d-4ba2-b9fc-69fdd516e2a2</ClientUUID><StartDate>20291023</StartDate><DueDate>20291028</DueDate></Job>"
      end

      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/connection/post") do
          example.run
        end
      end

      it "should post to Faraday with the right endpoint, data and headers" do
        connection = service.new(api_key: api_key, api_url: api_url, account_key: account_key)
        response = connection.post(endpoint: "job.api/add", data: xml_string)

        hash = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        expect(hash["Response"]["Status"]).to eq("OK")
      end
    end
  end
end
