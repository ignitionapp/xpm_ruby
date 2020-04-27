require "ox"

require_relative "models/staff"

module XpmRuby
  module Staff
    extend self

    class Error < Error; end

    def build(**args)
      Models::Staff.new(args)
    end

    def list(api_key:, account_key:, api_url:)
      Connection
        .new(api_key: api_key, account_key: account_key, api_url: api_url)
        .get(endpoint: "staff.api/list", element_name: "StaffList")
        .map do |staff|
          Models::Staff.new(
            uuid: staff["UUID"],
            name: staff["Name"],
            email: staff["Email"],
            phone: staff["Phone"],
            mobile: staff["Mobile"],
            address: staff["Address"],
            payroll_code: staff["PayrollCode"])
        end
      end
    end
  end
end
