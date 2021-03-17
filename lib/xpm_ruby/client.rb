module XpmRuby
  module Client
    extend self

    def add(access_token:, xero_tenant_id:, client:)
      validated_client = Schema::Client::Add[client]

      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .post(endpoint: "client.api/add", data: validated_client.to_xml(root: "Client"))

      response["Client"]
    end

    def update(access_token:, xero_tenant_id:, client:)
      validated_client = Schema::Client::Update[client]

      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .put(endpoint: "client.api/update", data: validated_client.to_xml(root: "Client"))

      response["Client"]
    end

    def list(access_token:, xero_tenant_id:, detailed: true, modified_since: nil, url: nil)
      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id, url: url)
        .get(
          endpoint: "client.api/list",
          params: {
            "detailed" => detailed,
            "modifiedsince" => modified_since }.compact)

      Array.wrap(response.dig("Clients", "Client"))
    end
  end
end
