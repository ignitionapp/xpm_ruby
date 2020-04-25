require "faraday"
require "base64"
require "ox"

require_relative "types/staff"

module XpmRuby
  module Staff
    extend self

    class Error < StandardError; end
    class TypeError < Error; end
    class Unauthorized < Error; end

    def build(**args)
      Types::Staff.new(args)
    rescue Dry::Struct::Error => error
      raise TypeError.new(error.message)
    end

    def list(api_key:, account_key:)
      key = Base64.strict_encode64("#{api_key}:#{account_key}")

      response = Faraday
        .new(
          url: "https://api.workflowmax.com/v3",
          headers: { "Authorization" => "Basic #{key}" })
        .get("staff.api/list")

      case response.status
      when 401
        hash = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        raise Unauthorized.new(hash["html"]["head"]["title"])
      when 200
        hash = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        case hash["Response"]["Status"]
        when "OK"
          hash["Response"]["StaffList"]["Staff"].map do |staff|
            build(
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
