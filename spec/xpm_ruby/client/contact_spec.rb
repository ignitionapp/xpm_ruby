require "spec_helper"

module XpmRuby
  module Client
    RSpec.describe(Contact) do
      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/client/contact/delete") do
          example.run
        end
      end

      describe ".delete" do
        let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
        let(:access_token) { "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFDQUY4RTY2NzcyRDZEQzAyOEQ2NzI2RkQwMjYxNTgxNTcwRUZDMTkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJISy1PWm5jdGJjQW8xbkp2MENZVmdWY09fQmsifQ.eyJuYmYiOjE1ODg1Njg5NzgsImV4cCI6MTU4ODU3MDc3OCwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS54ZXJvLmNvbSIsImF1ZCI6Imh0dHBzOi8vaWRlbnRpdHkueGVyby5jb20vcmVzb3VyY2VzIiwiY2xpZW50X2lkIjoiNDkyMjZBNjIzMzY0NDVFM0FGQUM5QTQ4MkJGOUUyN0UiLCJzdWIiOiIwY2FmMWU4MWYyZWE1MzdkYWIxYjYzNTY3NTc2ZDk3ZSIsImF1dGhfdGltZSI6MTU4ODU2ODk2OSwieGVyb191c2VyaWQiOiJmYzI5MDBjNy0wNjcyLTQzOGItOTNkMS1hOGMyNTBmZDg5MjkiLCJnbG9iYWxfc2Vzc2lvbl9pZCI6Ijg2YmJlZDQxYzEyOTQ1ZTQ4NWJlMmZmZmMwZDcxODU1IiwianRpIjoiNDAwNTYxZTliYmNjYWQwYjk3OTRiMjIxYTNkM2RmMzciLCJzY29wZSI6WyJlbWFpbCIsInByb2ZpbGUiLCJvcGVuaWQiLCJwcmFjdGljZW1hbmFnZXIiLCJvZmZsaW5lX2FjY2VzcyJdfQ.gVMav9yD4reWzAUS0KRM517b2rBAb1hkunkayEoE1plaI9NaV5mTG4SoGS04_Cq4_MhsLBYIwXauKHbgw8gpN17jpTf-JkG6eGDbvuItIXGEyvp4LRlIrJnJkpCcXZtuv8ASzmuEputYI85CpwJa-yXNZgkmQcZxsu7oGhGSR0zKRS1aVWuEEToNPCDL-y5n0Bd29RMdJXW4AFkITfIUiKUugF6Q2DvqBATVRl2jTq6mRdlexPnFuBk06DtVTukhDlc_z8M20rrg7BYDESQDNM1gnRGTMF4tVgTbC3Mjpqj-q8DeBp34I7biQWYrs9bM7rlz5BJz8f7jMOocbKNvzA" }

        let(:contact_id) { "14574323" }

        it "deletes the contact" do
          deleted_contact = Contact.delete(
            access_token: access_token,
            xero_tenant_id: xero_tenant_id,
            contact_id: contact_id)

          expect(deleted_contact["ID"]).to eql(contact_id)
          expect(deleted_contact["Name"]).to eql("some guy person")
        end
      end
    end
  end
end
