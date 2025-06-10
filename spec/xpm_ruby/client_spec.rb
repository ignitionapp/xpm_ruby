require "spec_helper"

module XpmRuby
  RSpec.describe(Client) do
    describe ".add" do
      include_context "xero credentials"

      let(:client) { { "Name" => "Acmer Pty Ltd" } }

      it "adds client" do
        VCR.use_cassette("xpm_ruby/client/add") do
          created_client = Client.add(
            access_token: access_token,
            xero_tenant_id: xero_tenant_id,
            client: client)

          expect(created_client["ID"]).not_to be_nil
          expect(created_client["Name"]).to eql(client["Name"])
        end
      end
    end

    describe ".update" do
      include_context "xero credentials"

      let(:client) { { "ID" => 25655881, "Name" => "Acmer Pty Ltd" } }

      it "updates client" do
        VCR.use_cassette("xpm_ruby/client/update") do
          updated_client = Client.update(
            access_token: access_token,
            xero_tenant_id: xero_tenant_id,
            client: client)

          expect(updated_client["ID"]).not_to be_nil
          expect(updated_client["Name"]).to eql(client["Name"])
        end
      end
    end

    describe ".get" do
      include_context "xero credentials"

      let(:client_id) { "32014284" }

      it "gets client information" do
        VCR.use_cassette("xpm_ruby/client/get") do
          client = Client.get(
            access_token: access_token,
            xero_tenant_id: xero_tenant_id,
            client_id: client_id
          )

          expect(client["ID"]).not_to be_nil
          expect(client["Name"]).to eql("Get Client Test")
        end
      end
    end

    describe ".list" do
      include_context "xero credentials"

      let(:access_token) { "token" }

      context "when not modified since" do
        it "list all clients" do
          VCR.use_cassette("xpm_ruby/client/list/when_not_modified_since") do
            clients = Client.list(access_token: access_token, xero_tenant_id: xero_tenant_id)

            expect(clients.count).to eq(12)
          end
        end
      end

      context "when modified since" do
        let(:modified_since) { "2020-05-05T06:24:31" }

        it "list clients modified since" do
          VCR.use_cassette("xpm_ruby/client/list/when_modified_since") do
            clients_list = Client.list(
              access_token: access_token,
              xero_tenant_id: xero_tenant_id,
              modified_since: modified_since)

            expect(clients_list.size).to eq(1)

            client = clients_list.first

            expect(client["ID"]).to eq("25655881")
          end
        end
      end

      context "when detailed false" do
        it "list clients without details" do
          VCR.use_cassette("xpm_ruby/client/list/when_detailed_false") do
            clients = Client.list(
              access_token: access_token,
              xero_tenant_id: xero_tenant_id,
              detailed: false)

            clients.each do |client|
              expect(client).not_to have_key("Notes")
              expect(client).not_to have_key("Groups")
              expect(client).not_to have_key("Relationships")
            end
          end
        end
      end

      context "when detailed true" do
        it "list clients with details" do
          VCR.use_cassette("xpm_ruby/client/list/when_detailed_true") do
            clients = Client.list(
              access_token: access_token,
              xero_tenant_id: xero_tenant_id,
              detailed: true)

            clients.each do |client|
              expect(client).to have_key("Notes")
              expect(client).to have_key("Groups")
              expect(client).to have_key("Relationships")
            end
          end
        end
      end
    end

    describe ".search" do
      subject(:search) do
        Client.search(access_token: access_token, xero_tenant_id: xero_tenant_id, query: query, detailed: detailed)
      end

      include_context "xero credentials"

      let(:query) { "acme" }

      context "when detailed false" do
        let(:detailed) { false }

        it "returns client search results without details" do
          VCR.use_cassette("xpm_ruby/client/search/when_detailed_false") do
            clients = search

            expect(clients.map { |client| client["Name"] }).to eq(["Acmer Pty Ltd", "Acmer Pty Ltd"])

            clients.each do |client|
              expect(client).not_to have_key("Notes")
              expect(client).not_to have_key("Groups")
              expect(client).not_to have_key("Relationships")
            end
          end
        end
      end

      context "when detailed true" do
        let(:detailed) { true }

        it "returns client search results with details" do
          VCR.use_cassette("xpm_ruby/client/search/when_detailed_true") do
            clients = search

            expect(clients.map { |client| client["Name"] }).to eq(["Acmer Pty Ltd", "Acmer Pty Ltd"])

            clients.each do |client|
              expect(client).to have_key("Notes")
              expect(client).to have_key("Groups")
              expect(client).to have_key("Relationships")
            end
          end
        end
      end
    end
  end
end
