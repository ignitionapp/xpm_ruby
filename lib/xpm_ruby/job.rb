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
        .get(endpoint: "job.api/get/#{job_id}")

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

    # The XML structure for job.assign does not fit in a Hash
    # so we need to pass in the XML directly.
    #
    # Returns the whole response — both "Status" and the "Job" describing the
    # assignment XPM confirmed — rather than digging out one of them, because a
    # caller checking the outcome and a caller reading the assignment both need
    # it and neither can recover the other half.
    def assign(access_token:, xero_tenant_id:, job_xml:)
      Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .put(endpoint: "job.api/assign", data: job_xml)
    end

    def applytemplate(access_token:, xero_tenant_id:, job:)
      validated_job = Schema::Job::Applytemplate[job]

      response = Connection
        .new(access_token: access_token, xero_tenant_id: xero_tenant_id)
        .post(endpoint: "job.api/applytemplate", data: validated_job.to_xml(root: "Job"))

      response["Job"]
    end
  end
end
