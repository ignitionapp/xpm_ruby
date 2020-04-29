require "ox"

module XpmRuby
  module Template
    extend self

    class Error < Error; end

    def build(**args)
      Models::Template.new(args)
    end

    def list(access_token:, xero_tenant_id:)
      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .get(endpoint: "template.api/list")

      response["Templates"]["Template"]
    end
  end
end
