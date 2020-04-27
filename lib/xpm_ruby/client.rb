require "faraday"
require "base64"
require "ox"

require_relative "models/client"

module XpmRuby
  module Client
    extend self

    class Error < StandardError; end
    class Unauthorized < Error; end

    def build(**args)
      Models::Client.new(args)
    end

    def add(api_key:, account_key:)
      response = Connection
        .new(api_key: api_key, account_key: account_key, api_url: api_url)
        .get(endpoint: "client.api/add")

      case response.status
      when 401
        hash = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        raise Unauthorized.new(hash["html"]["head"]["title"])
      when 200
        hash = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        case hash["Response"]["Status"]
        when "OK"
          hash["Response"]["Clients"]["Client"].map do |client|
            Models::Client.new(
              uuid: staff["UUID"],
              name: staff["Name"],
              email: staff["Email"],
              phone: staff["Phone"],
              mobile: staff["Mobile"],
              address: staff["Address"],
              payroll_code: staff["PayrollCode"])
          end
        when "ERROR"
          raise Error.new(response["ErrorDescription"])
        end
      else
        raise Error.new(response.status)
      end
    end
  end
end
