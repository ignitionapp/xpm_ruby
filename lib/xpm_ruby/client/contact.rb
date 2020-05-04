module XpmRuby
  module Client
    module Contact
      extend self

      def delete(access_token:, xero_tenant_id:, contact_id:)
        response = Connection
          .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
          .delete(endpoint: "client.api/contact", id: contact_id)

        response["Contact"]
      end
    end
  end
end
