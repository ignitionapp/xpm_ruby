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

    def get(endpoint:)
      Faraday.new("https://#{@api_url}/v3/#{endpoint}", headers: { 'Authorization' => @basic_auth }).get
    end
  end
end