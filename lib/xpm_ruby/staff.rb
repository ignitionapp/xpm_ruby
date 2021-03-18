require "ox"

module XpmRuby
  module Staff
    extend self

    class Error < Error; end

    def list(access_token:, xero_tenant_id:, url: nil)
      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id, url: url)
        .get(endpoint: "staff.api/list")

      Array.wrap(response.dig("StaffList", "Staff"))
    end
  end
end
