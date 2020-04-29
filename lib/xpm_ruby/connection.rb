require "faraday"
require "base64"

module XpmRuby
  class Connection
    attr_accessor :xero_tenant_id, :authorization

    def initialize(access_token:, xero_tenant_id:)
      @xero_tenant_id = xero_tenant_id
      @authorization = "Bearer " + access_token
    end

    def get(endpoint:, params: nil)
      faraday_connection = Faraday.new(url)
      faraday_connection.get(endpoint, params, headers)
    end

    def post(endpoint:, data:)
      faraday_connection = Faraday.new(url)
      faraday_connection.post(endpoint, data, headers)
    end

    private

    def headers
      { "Authorization" => @authorization, "xero-tenant-id" => @xero_tenant_id, "content_type" => "application/xml" }
    end

    def url
      "https://api.xero.com/practicemanager/3.0/"
    end
  end
end
