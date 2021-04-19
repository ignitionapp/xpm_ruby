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

    def add(access_token:, xero_tenant_id:, staff:)
      validated_contact = Schema::Staff::Add[staff]

      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .post(endpoint: "staff.api/add", data: validated_contact.to_xml(root: "Staff"))

      response["Staff"]
    end

    def update(access_token:, xero_tenant_id:, staff:)
      validated_contact = Schema::Staff::Update[staff]

      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .put(
          endpoint: "staff.api/update",
          data: validated_contact.to_xml(root: "Staff"))

      response["Staff"]
    end

    def delete(access_token:, xero_tenant_id:, id:)
      validated_contact = Schema::Staff::Delete[{ "ID" => id }]

      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .post(
          endpoint: "staff.api/delete",
          data: validated_contact.to_xml(root: "Staff"))

      response["Status"] == "OK"
    end
  end
end
