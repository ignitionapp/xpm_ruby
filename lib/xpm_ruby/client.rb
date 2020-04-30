module XpmRuby
  module Client
    extend self

    def add(access_token:, xero_tenant_id:, client:)
      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .post(endpoint: "client.api/add", data: client.to_xml(root: "Client"))

      response["Client"]
    end
  end
end
