require "ox"

module XpmRuby
  module Job
    extend self

    class Error < Error; end

    def build(**args)
      Models::Job.new(args)
    end

    def current(api_key:, account_key:, api_url:)
      response = Connection
        .new(api_key: api_key, account_key: account_key, api_url: api_url)
        .get(endpoint: "job.api/current")

      case response.status
      when 401
        hash = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        raise Unauthorized.new(hash["html"]["head"]["title"])
      when 200
        hash = Ox.load(response.body, mode: :hash_no_attrs, symbolize_keys: false)

        case hash["Response"]["Status"]
        when "OK"
          transformed_hash = hash.deep_transform_keys(&:underscore)
          transformed_hash["response"]["jobs"]["job"]
        when "ERROR"
          raise Error.new(response["ErrorDescription"])
        end
      else
        raise Error.new(response.status)
      end
    end
  end
end
