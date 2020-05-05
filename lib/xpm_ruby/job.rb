require "ox"

module XpmRuby
  module Job
    extend self

    class Error < Error; end

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

    def update(access_token:, xero_tenant_id:, job:)
      validated_job = Schema::Job::Update[job]

      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .put(endpoint: "job.api/update", data: validated_job.to_xml(root: "Job"))

      response["Job"]
    end

    def get(access_token:, xero_tenant_id:, job_id:)
      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .get(endpoint: "job.api/get/" + job_id)

      response["Job"]
    end

    def state(access_token:, xero_tenant_id:, job:)
      validated_job = Schema::Job::State[job]

      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .put(endpoint: "job.api/state", data: validated_job.to_xml(root: "Job"))

      response["Status"]
    end

    def delete(access_token:, xero_tenant_id:, job:)
      validated_job = Schema::Job::Delete[job]

      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .post(endpoint: "job.api/delete", data: validated_job.to_xml(root: "Job"))

      response["Status"]
    end
  end
end
