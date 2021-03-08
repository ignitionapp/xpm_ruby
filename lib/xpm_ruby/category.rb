require "ox"

module XpmRuby
  module Category
    extend self

    def list(access_token:, xero_tenant_id:)
      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .get(endpoint: "category.api/list")

      Array.wrap(response["Categories"]["Category"])
    end
  end
end
