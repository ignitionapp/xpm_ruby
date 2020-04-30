require "ox"

module XpmRuby
  module Job
    extend self

    class Error < Error; end

    def build(**args)
      Models::Job.new(args)
    end

    def current(access_token:, xero_tenant_id:)
      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .get(endpoint: "job.api/current")

      response["Jobs"]["Job"]
    end

    def add(access_token:, xero_tenant_id:, job:)
      validated_job = Schema::Job::Add[job]

      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .post(endpoint: "job.api/add", data: validated_job.to_xml(root: "Job"))

      response["Job"]
    end
  end
end
