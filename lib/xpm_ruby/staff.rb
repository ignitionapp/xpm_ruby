require "ox"

require_relative "models/staff"

module XpmRuby
  module Staff
    extend self

    class Error < Error; end

    def build(**args)
      Models::Staff.new(args)
    end

    def list(connection:)
      response = connection.get(endpoint: "staff.api/list")

      case response.status
      when 401
        hash = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        raise Unauthorized.new(hash["html"]["head"]["title"])
      when 200
        hash = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        case hash["Response"]["Status"]
        when "OK"
          hash["Response"]["StaffList"]["Staff"].map do |staff|
            Models::Staff.new(
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
