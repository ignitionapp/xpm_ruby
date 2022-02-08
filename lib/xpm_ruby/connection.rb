require "faraday"
require "faraday/encoding"
require "base64"

module XpmRuby
  class Connection
    attr_accessor :xero_tenant_id, :authorization, :url

    def initialize(access_token:, xero_tenant_id:, url: nil)
      @xero_tenant_id = xero_tenant_id
      @authorization = "Bearer #{access_token}"
      @url = url || xpm_url
    end

    def get(endpoint:, params: nil)
      response = build_connection(url: url).get(endpoint, params, headers)
      handle_response(response)
    rescue Faraday::ConnectionFailed => error
      raise ConnectionFailed.new(error.message)
    rescue Faraday::TimeoutError => error
      raise ConnectionTimeout.new(error.message)
    end

    def post(endpoint:, data:)
      response = build_connection(url: url).post(endpoint, data, headers)
      handle_response(response)
    rescue Faraday::ConnectionFailed => error
      raise ConnectionFailed.new(error.message)
    rescue Faraday::TimeoutError => error
      raise ConnectionTimeout.new(error.message)
    end

    def put(endpoint:, data:)
      response = build_connection(url: url).put(endpoint, data, headers)
      handle_response(response)
    rescue Faraday::ConnectionFailed => error
      raise ConnectionFailed.new(error.message)
    rescue Faraday::TimeoutError => error
      raise ConnectionTimeout.new(error.message)
    end

    def delete(endpoint:, id:)
      response = build_connection(url: url).delete("#{endpoint}/#{id}", nil, headers)
      handle_response(response)
    rescue Faraday::ConnectionFailed => error
      raise ConnectionFailed.new(error.message)
    rescue Faraday::TimeoutError => error
      raise ConnectionTimeout.new(error.message)
    end

    private

    def build_connection(url:, adapter: Faraday.default_adapter)
      Faraday.new(url) do |connection|
        # use Faraday::Encoding middleware to correct the response encoding.
        connection.response(:encoding)

        connection.adapter(adapter)
      end
    end

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
      when 503
        detail = JSON.parse(response.body)["Detail"]
        raise NotAvailable.new(detail)
      when 429 # rate limit exceeded
        details = response.headers.slice(
          "retry-after",
          "x-rate-limit-problem",
          "x-minlimit-remaining",
          "x-daylimit-remaining",
          "x-appminlimit-remaining"
        )
        raise RateLimitExceeded.new(response.reason_phrase, details: details)
      when 200
        xml = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        case xml["Response"]["Status"]
        when "OK"
          xml["Response"]
        when "ERROR"
          raise ApiError.new(xml["Response"]["ErrorDescription"])
        end
      else
        raise UnknownError.new(response.status)
      end
    end
  end
end
