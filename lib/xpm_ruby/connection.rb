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

    def get(endpoint:, element_name:)
      response = Faraday.new(url(endpoint: endpoint), headers: headers).get

      case response.status
      when 401
        hash = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        raise Unauthorized.new(hash["html"]["head"]["title"])
      when 200
        xml = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        case xml["Response"]["Status"]
        when "OK"
          xml["Response"][element_name]
        when "ERROR"
          raise Error.new(response["ErrorDescription"])
        end
      else
        raise Error.new(response.status)
      end
    end

    private

    def headers
      { "Authorization" => @basic_auth }
    end

    def url(endpoint:)
      "https://#{@api_url}/v3/#{endpoint}"
    end
  end
end
