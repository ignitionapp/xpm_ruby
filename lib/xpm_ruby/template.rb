require "ox"

require_relative "models/template"

module XpmRuby
  module Template
    extend self

    class Error < Error; end

    def build(**args)
      Models::Template.new(args)
    end

    def list(api_key:, account_key:, api_url:)
      response = Connection
        .new(api_key: api_key, account_key: account_key, api_url: api_url)
        .get(endpoint: "template.api/list")

      case response.status
      when 401
        hash = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        raise Unauthorized.new(hash["html"]["head"]["title"])
      when 200
        hash = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        case hash["Response"]["Status"]
        when "OK"
          hash["Response"]["Templates"]["Template"].map do |template|
            Models::Template.new(
              uuid: template["UUID"],
              name: template["Name"])
          end
        when "ERROR"
          raise Error.new(response["ErrorDescription"])
        end
      else
        raise Error.new(response.status)
      end
    end
  end
end
