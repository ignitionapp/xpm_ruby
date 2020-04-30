require "spec_helper"

module XpmRuby
  RSpec.describe(Job) do
    subject(:service) { described_class }

    describe ".current" do
      let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
      let(:access_token) { "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFDQUY4RTY2NzcyRDZEQzAyOEQ2NzI2RkQwMjYxNTgxNTcwRUZDMTkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJISy1PWm5jdGJjQW8xbkp2MENZVmdWY09fQmsifQ.eyJuYmYiOjE1ODgxMTUyMTQsImV4cCI6MTU4ODExNzAxNCwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS54ZXJvLmNvbSIsImF1ZCI6Imh0dHBzOi8vaWRlbnRpdHkueGVyby5jb20vcmVzb3VyY2VzIiwiY2xpZW50X2lkIjoiNDkyMjZBNjIzMzY0NDVFM0FGQUM5QTQ4MkJGOUUyN0UiLCJzdWIiOiIwY2FmMWU4MWYyZWE1MzdkYWIxYjYzNTY3NTc2ZDk3ZSIsImF1dGhfdGltZSI6MTU4ODA1MTE0MywieGVyb191c2VyaWQiOiJmYzI5MDBjNy0wNjcyLTQzOGItOTNkMS1hOGMyNTBmZDg5MjkiLCJnbG9iYWxfc2Vzc2lvbl9pZCI6IjQzMGI0ZmVmMWI0NjQ2MGZiMTgwOWNmNmQ5OWJhODIxIiwianRpIjoiMmI3NGQxZDZhMzcxNDlhN2VjNjkwNmM2NGM0MDFlMjEiLCJzY29wZSI6WyJlbWFpbCIsInByb2ZpbGUiLCJvcGVuaWQiLCJwcmFjdGljZW1hbmFnZXIiLCJvZmZsaW5lX2FjY2VzcyJdfQ.EJ5_dU4efS9e2w68A63GQaVWghmcIONEOfkB4Wp0IGNwTbNU441x3vSAMdRY5MShT1jk9cTR-207OKClFJAuwWZbODQcs2bV9YDj5PH9cCtNCULFOClQCn7zfUonkMdZ9FiL4RjJ6xXbWOmfD-vYhQRLbAkKDcZad8HcPIzPyKvyHFuxTDk7FKs-OI3sUPQUqQrBKAcmD2C8PR8al7PNn0kwrug1a2_R0z74Sygg1iKJlShMLMBbaDfq_7zxbMvGrLvW1vLMlJDhxD-sR4_T-B3n6_VDFybFfShQqtkoJwk4-fAqc0S8N0Vmx_kRLqzVEIE8NiouqnTvt6i8Bvc5PQ" }

      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/job/current") do
          example.run
        end
      end

      it "lists current jobs" do
        current_jobs = service.current(access_token: access_token, xero_tenant_id: xero_tenant_id)

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
      let(:access_token) { "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFDQUY4RTY2NzcyRDZEQzAyOEQ2NzI2RkQwMjYxNTgxNTcwRUZDMTkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJISy1PWm5jdGJjQW8xbkp2MENZVmdWY09fQmsifQ.eyJuYmYiOjE1ODgyMDg3MjksImV4cCI6MTU4ODIxMDUyOSwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS54ZXJvLmNvbSIsImF1ZCI6Imh0dHBzOi8vaWRlbnRpdHkueGVyby5jb20vcmVzb3VyY2VzIiwiY2xpZW50X2lkIjoiNDkyMjZBNjIzMzY0NDVFM0FGQUM5QTQ4MkJGOUUyN0UiLCJzdWIiOiIwY2FmMWU4MWYyZWE1MzdkYWIxYjYzNTY3NTc2ZDk3ZSIsImF1dGhfdGltZSI6MTU4ODIwODU3NSwieGVyb191c2VyaWQiOiJmYzI5MDBjNy0wNjcyLTQzOGItOTNkMS1hOGMyNTBmZDg5MjkiLCJnbG9iYWxfc2Vzc2lvbl9pZCI6IjZmYWRiYTVmYWI3NTQ0NDliNjkwMGE1NzI3OGVlMjc5IiwianRpIjoiZmU2MjUyNzNhNmEwMTI4YjI2N2IxYmI1YWQzMGVkODgiLCJzY29wZSI6WyJlbWFpbCIsInByb2ZpbGUiLCJvcGVuaWQiLCJwcmFjdGljZW1hbmFnZXIiLCJvZmZsaW5lX2FjY2VzcyJdfQ.iL5C3Lcc1KuxTcIMUNUdKfqRoB13flB46dyQ2fUcQesF_lloofR9qWzt1uijc91qQPnkyrgb_Kv2aGvR3YvXXM1naK2Wy87wfAJwonkAGm6IcIIeukgvvJMt3bNZvow-lrk2eb9Wfcz7xt_nJSqL9lr8YV9T5f56IWJzZJzwAiNYz4F1lmqzKMwX5fUU9gYHucgIgQAwDaD3AGPdB-AC71ZNw2Zwsshebv89CbSbpw7rGU9gEhHnI7PjXXYwRn430Zh9k0ruD7IQWNRMh26oS_PR4zIEFDGBn5xBdnm9jLWl9juQUkn0OPQvAwkEuM54AXSWaAgyeasdOtDNjD8JMA" }
      let(:job) { { "Name" => "Joe Bloggs", "Description" => "New Job", "ClientID" => "24097642", "StartDate" => "20091023", "DueDate" => "20091023" } }

      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/job/add") do
          example.run
        end
      end

      it "lists adds a job" do
        added_job = service.add(access_token: access_token, xero_tenant_id: xero_tenant_id, job: job)

        expect(added_job["Name"]).to eql(job["Name"])
        expect(added_job["Description"]).to eql(job["Description"])
        expect(added_job["Client"]["ID"]).to eql(job["ClientID"])
        expect(added_job["StartDate"]).to eql("2009-10-23T00:00:00")
        expect(added_job["DueDate"]).to eql("2009-10-23T00:00:00")
      end
    end
  end
end
