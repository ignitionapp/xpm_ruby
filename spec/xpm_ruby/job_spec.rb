require "spec_helper"

module XpmRuby
  RSpec.describe(Job) do
    subject(:service) { described_class }

    describe ".current" do
      let(:api_key) { "12C9DCD68EDF471CB17C764C70A01FAA" }
      let(:account_key) { "4FA62AC06CCB47A38D28B86EF25E97DC" }
      let(:api_url) { "api.workflowmax.com" }

      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/job/current") do
          example.run
        end
      end

      it "lists current jobs" do
        current_jobs = service.current(api_key: api_key, account_key: account_key, api_url: api_url)

        expect(current_jobs.length).to eq(2)

        first_job = current_jobs.first

        expect(first_job.name).to eql("Internal Time")
        expect(first_job.uuid).to eql("f6273477-e0d6-4122-b3ff-8373f285aaa7")
        expect(first_job.description).to eql("Use this job to record your internal and non-billable time for activities such as annual leave, sick leave, professional development, staff meetings etc")
        expect(first_job.state).to eql("Planned")
        expect(first_job.start_date).to eql("2020-04-20T00:00:00")
        expect(first_job.due_date).to eql("2021-04-20T00:00:00")
        expect(first_job.completed_date).to be_nil
      end
    end
  end
end
