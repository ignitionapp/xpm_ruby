module XpmRuby
  module Contact
    extend self

    def add(access_token:, xero_tenant_id:, contact:)
      validated_contact = Schema::Contact::Add[contact]

      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .post(endpoint: "client.api/contact", data: validated_contact.to_xml(root: "Contact"))

      response["Contact"]
    end

    def update(access_token:, xero_tenant_id:, id:, contact:)
      validated_contact = Schema::Contact::Update[contact]

      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .put(
          endpoint: "client.api/contact/#{id}",
          data: validated_contact.to_xml(root: "Contact"))

      response["Contact"]
    end

    def delete(access_token:, xero_tenant_id:, contact_id:)
      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .delete(endpoint: "client.api/contact", id: contact_id)

      response["Contact"]
    end
  end
end
