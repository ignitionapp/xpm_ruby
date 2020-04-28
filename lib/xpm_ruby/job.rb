require "ox"

require_relative "models/job"

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
          hash["Response"]["Jobs"]["Job"].map do |job|
            Models::Job.new(
              uuid: job["UUID"],
              name: job["Name"],
              description: job["Description"],
              start_date: job["StartDate"],
              due_date: job["DueDate"],
              completed_date: job["CompletedDate"],
              state: job["State"])
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
