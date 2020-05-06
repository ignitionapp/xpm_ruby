require "spec_helper"

module XpmRuby
  RSpec.describe(Job) do
    describe ".current" do
      let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
      let(:access_token) { "token" }

      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/job/current") do
          example.run
        end
      end

      it "lists current jobs" do
        current_jobs = Job.current(access_token: access_token, xero_tenant_id: xero_tenant_id)

        expect(current_jobs.length).to eq(29)

        first_job = current_jobs.first

        expect(first_job["Name"]).to eql("(Sample) Bookkeeping Monthly - Basic")
        expect(first_job["ID"]).to eql("J000014")
        expect(first_job["State"]).to eql("Planned")
        expect(first_job["StartDate"]).to eql("2019-11-01T00:00:00")
        expect(first_job["DueDate"]).to eql("2019-11-07T00:00:00")
        expect(first_job["CompletedDate"]).to be_nil
      end
    end

    describe ".add" do
      let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
      let(:access_token) { "token" }
      let(:job) { { "Name" => "Joe Bloggs", "Description" => "New Job", "ClientID" => "24097642", "StartDate" => "20091023", "DueDate" => "20091023" } }

      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/job/add") do
          example.run
        end
      end

      it "adds a job" do
        added_job = Job.add(access_token: access_token, xero_tenant_id: xero_tenant_id, job: job)

        expect(added_job["Name"]).to eql(job["Name"])
        expect(added_job["Description"]).to eql(job["Description"])
        expect(added_job["Client"]["ID"]).to eql(job["ClientID"])
        expect(added_job["StartDate"]).to eql("2009-10-23T00:00:00")
        expect(added_job["DueDate"]).to eql("2009-10-23T00:00:00")
      end
    end

    describe ".update" do
      let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
      let(:access_token) { "token" }
      let(:job) { { "ID" => "J000031", "Name" => "Joe Bloggs", "Description" => "Update Job", "ClientID" => "24097642", "StartDate" => "20091023", "DueDate" => "20091023" } }

      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/job/update") do
          example.run
        end
      end

      it "updates a job" do
        updated_job = Job.update(access_token: access_token, xero_tenant_id: xero_tenant_id, job: job)

        expect(updated_job["ID"]).to eql(job["ID"])
        expect(updated_job["Name"]).to eql(job["Name"])
        expect(updated_job["Description"]).to eql(job["Description"])
        expect(updated_job["Client"]["ID"]).to eql(job["ClientID"])
        expect(updated_job["StartDate"]).to eql("2009-10-23T00:00:00")
        expect(updated_job["DueDate"]).to eql("2009-10-23T00:00:00")
      end
    end

    describe ".get" do
      let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
      let(:access_token) { "token" }
      let(:job_id) { "J000014" }

      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/job/get") do
          example.run
        end
      end

      it "gets the job details" do
        job = Job.get(access_token: access_token, xero_tenant_id: xero_tenant_id, job_id: job_id)

        expect(job["Name"]).to eql("(Sample) Bookkeeping Monthly - Basic")
        expect(job["ID"]).to eql("J000014")
        expect(job["State"]).to eql("Planned")
        expect(job["StartDate"]).to eql("2019-11-01T00:00:00")
        expect(job["DueDate"]).to eql("2019-11-07T00:00:00")
        expect(job["CompletedDate"]).to be_nil
      end
    end

    describe ".state" do
      let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
      let(:access_token) { "token" }

      context "when the job state is successful" do
        let(:job) { { "ID" => "J000031", "State" => "COMPLETED" } }

        it "sets the state on the job" do
          VCR.use_cassette("xpm_ruby/job/state/success") do
            response = Job.state(access_token: access_token, xero_tenant_id: xero_tenant_id, job: job)
            expect(response).to eq("OK")
          end
        end
      end

      context "when it is not successful" do
        let(:job) { { "ID" => "J000031", "State" => "NONEXISTENT" } }

        it "reports the error" do
          VCR.use_cassette("xpm_ruby/job/state/fail") do
            expect { Job.state(access_token: access_token, xero_tenant_id: xero_tenant_id, job: job) }.to raise_error(XpmRuby::Error, /Invalid state code/)
          end
        end
      end
    end

    describe ".delete" do
      let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
      let(:access_token) { "token" }

      context "with a valid job id" do
        let(:job) { { "ID" => "J000031" } }

        it "updates a job" do
          VCR.use_cassette("xpm_ruby/job/delete") do
            response = Job.delete(access_token: access_token, xero_tenant_id: xero_tenant_id, job: job)

            expect(response).to eq("OK")
          end
        end
      end

      context "with an invalid job id" do
        let(:job) { { "ID" => "none" } }

        it "returns an error" do
          VCR.use_cassette("xpm_ruby/job/delete/error") do
            expect { Job.delete(access_token: access_token, xero_tenant_id: xero_tenant_id, job: job) }.to raise_error(XpmRuby::Error, /Invalid job identifier/)
          end
        end
      end
    end

    describe ".assign" do
      let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
      let(:access_token) { "token" }

      context "add and remove staff" do
        context "with a valid job id and staff id" do
          let(:job_xml) { '<Job><ID>J000032</ID><add id="859230" /> </Job>' }

          it "updates a job" do
            VCR.use_cassette("xpm_ruby/job/assign") do
              response = Job.assign(access_token: access_token, xero_tenant_id: xero_tenant_id, job_xml: job_xml)

              expect(response).to eq("OK")
            end
          end
        end

        context "remove with a valid job id and staff id" do
          let(:job_xml) { '<Job><ID>J000032</ID><remove id="859230" /> </Job>' }

          it "updates a job" do
            VCR.use_cassette("xpm_ruby/job/assign/remove") do
              response = Job.assign(access_token: access_token, xero_tenant_id: xero_tenant_id, job_xml: job_xml)

              expect(response).to eq("OK")
            end
          end
        end
      end

      context "add and remove manager" do
        context "with a valid job id and staff id" do
          let(:job_xml) { '<Job><ID>J000032</ID><add-manager id="859230" /> </Job>' }

          it "updates a job" do
            VCR.use_cassette("xpm_ruby/job/assign/manager") do
              response = Job.assign(access_token: access_token, xero_tenant_id: xero_tenant_id, job_xml: job_xml)

              expect(response).to eq("OK")
            end
          end
        end

        context "remove with a valid job id and staff id" do
          let(:job_xml) { "<Job><ID>J000032</ID><remove-manager /> </Job>" }

          it "updates a job" do
            VCR.use_cassette("xpm_ruby/job/assign/removemanager") do
              response = Job.assign(access_token: access_token, xero_tenant_id: xero_tenant_id, job_xml: job_xml)

              expect(response).to eq("OK")
            end
          end
        end
      end

      context "add and remove partner" do
        context "with a valid job id and staff id" do
          let(:job_xml) { '<Job><ID>J000032</ID><add-partner id="859230" /> </Job>' }

          it "updates a job" do
            VCR.use_cassette("xpm_ruby/job/assign/partner") do
              response = Job.assign(access_token: access_token, xero_tenant_id: xero_tenant_id, job_xml: job_xml)

              expect(response).to eq("OK")
            end
          end
        end

        context "remove with a valid job id and staff id" do
          let(:job_xml) { "<Job><ID>J000032</ID><remove-partner /> </Job>" }

          it "updates a job" do
            VCR.use_cassette("xpm_ruby/job/assign/removepartner") do
              response = Job.assign(access_token: access_token, xero_tenant_id: xero_tenant_id, job_xml: job_xml)

              expect(response).to eq("OK")
            end
          end
        end
      end

      context "with an invalid job id" do
        let(:job_xml) { '<Job><ID>none</ID><add id="859230"/> </Job>' }

        it "returns an error" do
          VCR.use_cassette("xpm_ruby/job/assign/invalidjob") do
            expect { Job.assign(access_token: access_token, xero_tenant_id: xero_tenant_id, job_xml: job_xml) }.to raise_error(XpmRuby::Error, /Invalid job identifier/)
          end
        end
      end

      context "with an invalid staff id" do
        let(:job_xml) { '<Job><ID>J000032</ID><add id="none"/> </Job>' }

        it "returns an error" do
          VCR.use_cassette("xpm_ruby/job/assign/invalidstaff") do
            expect { Job.assign(access_token: access_token, xero_tenant_id: xero_tenant_id, job_xml: job_xml) }.to raise_error(XpmRuby::Error, /Invalid staff identifier for add request/)
          end
        end
      end
    end

    describe ".applytemplate" do
      let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
      let(:access_token) { "token" }



      context "with valid job and template" do
        let(:job) { { "ID" => "J000032", "TemplateID" => 1254078, "TaskMode" => "AddNew" } }

        it "applies the template to a job" do
          VCR.use_cassette("xpm_ruby/job/applytemplate") do
            applied_job = Job.applytemplate(access_token: access_token, xero_tenant_id: xero_tenant_id, job: job)

            expect(applied_job["ID"]).to eql(job["ID"])
          end
        end
      end

      context "with invalid job" do
        let(:job) { { "ID" => "none", "TemplateID" => 1254078, "TaskMode" => "AddNew" } }

        it "throws invalid job error" do
          VCR.use_cassette("xpm_ruby/job/applytemplate/invalidjob") do
            expect { Job.applytemplate(access_token: access_token, xero_tenant_id: xero_tenant_id, job: job) }.to raise_error(XpmRuby::Error, /Invalid job identifier/)
          end
        end
      end

      context "with invalid template" do
        let(:job) { { "ID" => "J000032", "TemplateID" => 1000, "TaskMode" => "AddNew" } }

        it "throws invalid job error" do
          VCR.use_cassette("xpm_ruby/job/applytemplate/invalidtemplate") do
            expect { Job.applytemplate(access_token: access_token, xero_tenant_id: xero_tenant_id, job: job) }.to raise_error(XpmRuby::Error, /Invalid job template identifier/)
          end
        end
      end
    end
  end
end
