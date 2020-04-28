require "faraday"
require "base64"

module XpmRuby
  class Connection
    attr_accessor :api_url, :account_key, :api_key, :basic_auth

    def initialize(account_key:, api_key:, api_url:)
      @api_url = api_url
      @account_key = account_key
      @api_key = api_key
      @basic_auth = "Basic " + Base64.strict_encode64("#{api_key}:#{account_key}")
    end

    def get(endpoint:, params: nil)
      faraday_connection = Faraday.new(url)
      faraday_connection.get(endpoint, params, headers)
    end

    def post(endpoint:, data:)
      faraday_connection = Faraday.new(url)
      puts headers.merge(content_type: "application/xml")
      faraday_connection.post(endpoint, data, headers.merge(content_type: "application/xml"))
    end

    private

    def headers
      { "Authorization" => @basic_auth }
    end

    def url
      "https://#{@api_url}/v3/"
    end
  end
end
