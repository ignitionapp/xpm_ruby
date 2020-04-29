require "spec_helper"

module XpmRuby
  RSpec.describe(Staff) do
    subject(:service) { described_class }

    describe ".list" do
      context "when keys invalid" do
        let(:api_key) { "" }
        let(:account_key) { "" }
        let(:api_url) { "api.workflowmax.com" }

        xit "raises unauthorized error" do
          expect do
            Staff.list(api_key: api_key, account_key: account_key, api_url: api_url)
          end.to raise_error(Unauthorized)
        end
      end

      context "when keys valid" do
        let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
        let(:access_token) { "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFDQUY4RTY2NzcyRDZEQzAyOEQ2NzI2RkQwMjYxNTgxNTcwRUZDMTkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJISy1PWm5jdGJjQW8xbkp2MENZVmdWY09fQmsifQ.eyJuYmYiOjE1ODgxMTc2NDQsImV4cCI6MTU4ODExOTQ0NCwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS54ZXJvLmNvbSIsImF1ZCI6Imh0dHBzOi8vaWRlbnRpdHkueGVyby5jb20vcmVzb3VyY2VzIiwiY2xpZW50X2lkIjoiNDkyMjZBNjIzMzY0NDVFM0FGQUM5QTQ4MkJGOUUyN0UiLCJzdWIiOiIwY2FmMWU4MWYyZWE1MzdkYWIxYjYzNTY3NTc2ZDk3ZSIsImF1dGhfdGltZSI6MTU4ODA1MTE0MywieGVyb191c2VyaWQiOiJmYzI5MDBjNy0wNjcyLTQzOGItOTNkMS1hOGMyNTBmZDg5MjkiLCJnbG9iYWxfc2Vzc2lvbl9pZCI6IjQzMGI0ZmVmMWI0NjQ2MGZiMTgwOWNmNmQ5OWJhODIxIiwianRpIjoiMmI3NGQxZDZhMzcxNDlhN2VjNjkwNmM2NGM0MDFlMjEiLCJzY29wZSI6WyJlbWFpbCIsInByb2ZpbGUiLCJvcGVuaWQiLCJwcmFjdGljZW1hbmFnZXIiLCJvZmZsaW5lX2FjY2VzcyJdfQ.HhzdzozbWidNt8ugO43wPpJhh1H_52khXAxzfwiyXn4r9eBO2qFrYNbVHliDzQrWNurTWnnWttWomCOjfaXpJ0h5m85r6H2h0_nUvd6OnNDEl6yD5Lfqfk1TxbxkEOu2UlJq8pFgeq4dLP9QUpjmJG2cff4bGu809uGDO-lARX1MhZOCUzVCJWdOClZlPivu-zwp8vMDItGCrt-HY8v874X8PNhqiX9aSwZIRzuyNfd71ok0VbGvLeoAxkY-Ph4NdAs-Gvn21S_6-9dIPohtxthqPxDJA3FOJBbQ_OL4y35EkaN3IlNp8J3WILIbjz541OHFCd6nBPGHuByGNMZslg" }

        around(:each) do |example|
          VCR.use_cassette("xpm_ruby/staff/list") do
            example.run
          end
        end

        it "lists staff" do
          staff_list = service.list(access_token: access_token, xero_tenant_id: xero_tenant_id)

          staff = staff_list.last

          expect(staff["Name"]).to eql("test")
          expect(staff["Email"]).to eql("adammikulas@gmail.com")
          # expect(staff.uuid).to eql("1cc99c1e-8cf7-4248-ab84-3e11126facbc")
        end
      end
    end
  end
end
