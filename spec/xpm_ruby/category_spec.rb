require "spec_helper"

module XpmRuby
  RSpec.describe(Category) do
    subject(:service) { described_class }

    describe ".list" do
      let(:xero_tenant_id) { "XERO_TENANT_ID" }
      let(:access_token) { "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFDQUY4RTY2NzcyRDZEQzAyOEQ2NzI2RkQwMjYxNTgxNTcwRUZDMTkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJISy1PWm5jdGJjQW8xbkp2MENZVmdWY09fQmsifQ.eyJuYmYiOjE2MTUxNTY2NDAsImV4cCI6MTYxNTE1ODQ0MCwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS54ZXJvLmNvbSIsImF1ZCI6Imh0dHBzOi8vaWRlbnRpdHkueGVyby5jb20vcmVzb3VyY2VzIiwiY2xpZW50X2lkIjoiNDkyMjZBNjIzMzY0NDVFM0FGQUM5QTQ4MkJGOUUyN0UiLCJzdWIiOiIwY2FmMWU4MWYyZWE1MzdkYWIxYjYzNTY3NTc2ZDk3ZSIsImF1dGhfdGltZSI6MTYxNTE1NjYzMCwieGVyb191c2VyaWQiOiJmYzI5MDBjNy0wNjcyLTQzOGItOTNkMS1hOGMyNTBmZDg5MjkiLCJnbG9iYWxfc2Vzc2lvbl9pZCI6ImE2ZTlhNTgzMzA0MzQxMzdhNjY3MGJjODc3M2FmNzJhIiwianRpIjoiMTYxZDQ5YTEzZGZlZGJmNjAwZjYzYTFlZjgwOTY0ZTYiLCJhdXRoZW50aWNhdGlvbl9ldmVudF9pZCI6ImQwMjAxZWMwLTM3YzQtNDllZi1iYWRlLWFkZDQ1YWUyZjcxMCIsInNjb3BlIjpbImVtYWlsIiwicHJvZmlsZSIsIm9wZW5pZCIsIndvcmtmbG93bWF4IiwicHJhY3RpY2VtYW5hZ2VyIiwib2ZmbGluZV9hY2Nlc3MiXX0.d2Fs9H5ZYu1FkQCaxdjq3f26N3Aq9KeJbUH9njX5kVXUBOXdUxxO7YCr0qgGhKWSTkik530gm53W5LrubN6kcEmKWgvgqtuQAK1p6_IBEkk6jdFHzjkLLP23RJ2eGTNdc_t7WRbtVI45Uh16EOMdVZV4jWfu_4T2wm3gNYXUnH3DEC4sFqhjtYIK6HMD4gxs1HSed1fXgxst9YdnkDkMzVB1gKuwD83cCiMz12V6u5eRgO4qUkBcMP7h1mRHnWe77QEvvs2JGPAeaxlWnXIWUqmfOm1VqgHIw6ML4MsgiiVdcwZsG10yqzNR07iIyzSx2GKjnlpZXRaAlQ0u-hqCiw" }

      around(:each) do |example|
        VCR.use_cassette("xpm_ruby/category/list") do
          example.run
        end
      end

      it "lists categories" do
        categories_list = service.list(access_token: access_token, xero_tenant_id: xero_tenant_id)

        expect(categories_list.length).to eq(3)

        category = categories_list.first

        expect(category["Name"]).to eql("Compliance")
        expect(category["ID"]).to eql("304252")
      end
    end
  end
end
