require "ox"

module XpmRuby
  module Template
    extend self

    class Error < Error; end

    def list(access_token:, xero_tenant_id:)
      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .get(endpoint: "template.api/list")

      Array.wrap(response.dig("Templates", "Template"))
    end
  end
end
