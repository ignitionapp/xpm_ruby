require "spec_helper"

module XpmRuby
  RSpec.describe(Client) do
    around(:each) do |example|
      VCR.use_cassette("xpm_ruby/client/add") do
        example.run
      end
    end

    describe ".add" do
      let(:xero_tenant_id) { "0791dc22-8611-4c1c-8df7-1c5453d0795b" }
      let(:access_token) { "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFDQUY4RTY2NzcyRDZEQzAyOEQ2NzI2RkQwMjYxNTgxNTcwRUZDMTkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJISy1PWm5jdGJjQW8xbkp2MENZVmdWY09fQmsifQ.eyJuYmYiOjE1ODgxMzA0NzQsImV4cCI6MTU4ODEzMjI3NCwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS54ZXJvLmNvbSIsImF1ZCI6Imh0dHBzOi8vaWRlbnRpdHkueGVyby5jb20vcmVzb3VyY2VzIiwiY2xpZW50X2lkIjoiNDkyMjZBNjIzMzY0NDVFM0FGQUM5QTQ4MkJGOUUyN0UiLCJzdWIiOiIwY2FmMWU4MWYyZWE1MzdkYWIxYjYzNTY3NTc2ZDk3ZSIsImF1dGhfdGltZSI6MTU4ODEzMDQ2NCwieGVyb191c2VyaWQiOiJmYzI5MDBjNy0wNjcyLTQzOGItOTNkMS1hOGMyNTBmZDg5MjkiLCJnbG9iYWxfc2Vzc2lvbl9pZCI6IjI5ZTUzOGU0NDBlMTQ3MTZiZjNiMmNkY2QwMWQ5NjFhIiwianRpIjoiOTBmZWVhYzIzNGMwOGVhMzlmYTY1ZGZkZTZhMzI5YmUiLCJzY29wZSI6WyJlbWFpbCIsInByb2ZpbGUiLCJvcGVuaWQiLCJwcmFjdGljZW1hbmFnZXIiLCJvZmZsaW5lX2FjY2VzcyJdfQ.LVkwLJ1lIjssKoO0tDFZFDV8n0pSEYqYs92E_c4uXwlkJNUZaJJ53PAxlobe9RjpboX1qMnq4ZDrbC6LH2w9ay7PISje-9T_fbGk7YrUKDqVJ_JsfuQruTSfqhrnRw3l_s8uP42HGCV-VoC9rBhiNzxydSvBU0nxAkOSGjuZvSQg75XJhhmTM-uO9bdo4q_V_9tZUgnv7UBVzirrcF6wntYPH2eTSguYON4dxo5FG60BnGa7rKgJjSB9PeJPosoOpHkauLOeWS955tu7ki4_1ANZk0v55MILjyb37vDT4e8fPSbmgr0yHSCXJ56qd0VTkSylFOqEgetLw3QD2WfMGQ" }

      let(:client) { { "Name" => "Acmer Pty Ltd" } }

      it "adds client" do
        created_client = Client.add(
          access_token: access_token,
          xero_tenant_id: xero_tenant_id,
          client: client)

        expect(created_client["ID"]).not_to be_nil
        expect(created_client["Name"]).to eql(client["Name"])
      end
    end
  end
end
