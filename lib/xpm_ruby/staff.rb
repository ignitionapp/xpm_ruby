require "ox"

module XpmRuby
  module Staff
    extend self

    class Error < Error; end

    def build(**args)
      Models::Staff.new(args)
    end

    def list(access_token:, xero_tenant_id:)
      Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .get(endpoint: "staff.api/list")["StaffList"]["Staff"]
    end
  end
end
