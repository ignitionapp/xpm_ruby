require "spec_helper"

module XpmRuby
  RSpec.describe(Template) do
    subject(:service) { described_class }

    describe ".list" do
      let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
      let(:access_token) { "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFDQUY4RTY2NzcyRDZEQzAyOEQ2NzI2RkQwMjYxNTgxNTcwRUZDMTkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJISy1PWm5jdGJjQW8xbkp2MENZVmdWY09fQmsifQ.eyJuYmYiOjE1ODgxMTc2NDQsImV4cCI6MTU4ODExOTQ0NCwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS54ZXJvLmNvbSIsImF1ZCI6Imh0dHBzOi8vaWRlbnRpdHkueGVyby5jb20vcmVzb3VyY2VzIiwiY2xpZW50X2lkIjoiNDkyMjZBNjIzMzY0NDVFM0FGQUM5QTQ4MkJGOUUyN0UiLCJzdWIiOiIwY2FmMWU4MWYyZWE1MzdkYWIxYjYzNTY3NTc2ZDk3ZSIsImF1dGhfdGltZSI6MTU4ODA1MTE0MywieGVyb191c2VyaWQiOiJmYzI5MDBjNy0wNjcyLTQzOGItOTNkMS1hOGMyNTBmZDg5MjkiLCJnbG9iYWxfc2Vzc2lvbl9pZCI6IjQzMGI0ZmVmMWI0NjQ2MGZiMTgwOWNmNmQ5OWJhODIxIiwianRpIjoiMmI3NGQxZDZhMzcxNDlhN2VjNjkwNmM2NGM0MDFlMjEiLCJzY29wZSI6WyJlbWFpbCIsInByb2ZpbGUiLCJvcGVuaWQiLCJwcmFjdGljZW1hbmFnZXIiLCJvZmZsaW5lX2FjY2VzcyJdfQ.HhzdzozbWidNt8ugO43wPpJhh1H_52khXAxzfwiyXn4r9eBO2qFrYNbVHliDzQrWNurTWnnWttWomCOjfaXpJ0h5m85r6H2h0_nUvd6OnNDEl6yD5Lfqfk1TxbxkEOu2UlJq8pFgeq4dLP9QUpjmJG2cff4bGu809uGDO-lARX1MhZOCUzVCJWdOClZlPivu-zwp8vMDItGCrt-HY8v874X8PNhqiX9aSwZIRzuyNfd71ok0VbGvLeoAxkY-Ph4NdAs-Gvn21S_6-9dIPohtxthqPxDJA3FOJBbQ_OL4y35EkaN3IlNp8J3WILIbjz541OHFCd6nBPGHuByGNMZslg" }

      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/template/list") do
          example.run
        end
      end

      it "lists templates" do
        template_list = service.list(access_token: access_token, xero_tenant_id: xero_tenant_id)

        expect(template_list.length).to eq(11)

        template = template_list.first

        expect(template.name).to eql("Activity Statement")
        # expect(template.uuid).to eql("d5dd52a0-edc1-4b03-94e7-931aa34ab35c")
      end
    end
  end
end
