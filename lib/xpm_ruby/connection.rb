require "faraday"
require "base64"

module XpmRuby
  class Connection
    attr_accessor :xero_tenant_id, :authorization, :url

    def initialize(access_token:, xero_tenant_id:, url: nil)
      @xero_tenant_id = xero_tenant_id
      @authorization = "Bearer " + access_token
      @url = url || xpm_url
    end

    def get(endpoint:, params: nil)
      faraday_connection = Faraday.new(url)
      response = faraday_connection.get(endpoint, params, headers)
      handle_response(response)
    end

    def post(endpoint:, data:)
      faraday_connection = Faraday.new(url)
      response = faraday_connection.post(endpoint, data, headers)
      handle_response(response)
    end

    def put(endpoint:, data:)
      faraday_connection = Faraday.new(url)
      response = faraday_connection.put(endpoint, data, headers)
      handle_response(response)
    end

    def delete(endpoint:, id:)
      faraday_connection = Faraday.new(url)
      response = faraday_connection.delete("#{endpoint}/#{id}", nil, headers)
      handle_response(response)
    end

    private

    def headers
      { "Authorization" => @authorization, "xero-tenant-id" => @xero_tenant_id, "content_type" => "application/xml" }
    end

    def xpm_url
      "https://api.xero.com/practicemanager/3.0/"
    end

    def handle_response(response)
      case response.status
      when 401
        detail = JSON.parse(response.body)["Detail"]

        case detail
        when /TokenExpired: token expired/
          raise AccessTokenExpired.new(detail)
        else
          raise Unauthorized.new(detail)
        end
      when 403 # this can happen with a bad xero_tenant_id
        detail = JSON.parse(response.body)["Detail"]
        raise Forbidden.new(detail)
      when 429 # rate limit exceeded
        raise RateLimitExceeded
      when 200
        xml = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        case xml["Response"]["Status"]
        when "OK"
          xml["Response"]
        when "ERROR"
          raise Error.new(xml["Response"]["ErrorDescription"])
        end
      else
        raise Error.new(response.status)
      end
    end
  end
end
