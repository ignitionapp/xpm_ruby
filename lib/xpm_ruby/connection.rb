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
      response = faraday_connection.get(endpoint, params, headers)

      case response.status
      when 401
        detail = JSON.parse(response.body)["Detail"]

        case detail
        when /TokenExpired: token expired/
          raise AccessTokenExpired.new(detail)
        else
          raise Unauthorized.new(detail)
        end
      when 200
        xml = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        case xml["Response"]["Status"]
        when "OK"
          xml["Response"]
        when "ERROR"
          raise Error.new(response["ErrorDescription"])
        end
      else
        raise Error.new(response.status)
      end
    end

    def post(endpoint:, data:)
      faraday_connection = Faraday.new(url)
      response = faraday_connection.post(endpoint, data, headers)

      case response.status
      when 401
        hash = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        raise Unauthorized.new(hash["html"]["head"]["title"])
      when 200
        xml = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        case xml["Response"]["Status"]
        when "OK"
          xml["Response"]
        when "ERROR"
          raise Error.new(response["ErrorDescription"])
        end
      else
        raise Error.new(response.status)
      end
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
