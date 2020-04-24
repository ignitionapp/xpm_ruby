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
  end
end
