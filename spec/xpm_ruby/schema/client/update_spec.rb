require "spec_helper"

module XpmRuby
  module Schema
    RSpec.describe(Client) do
      context "with a valid Update schema" do
        context "with contacts" do
          it "should not raise an error" do
            hash = { "ID" => 25655881, "Name" => "Joe Bloggs Consulting", "Contacts" => [{ "Contact" => { "Name" => "Joe Bloggs" } }] }
            expect { Client::Update[hash] }.not_to raise_error
          end
        end

        context "without contacts" do
          it "should not raise an error" do
            hash = { "ID" => 25655881, "Name" => "Joe Bloggs Consulting" }
            expect { Client::Update[hash] }.not_to raise_error
          end
        end

        it "should coerce the types" do
          hash = { "ID" => 25655881, "Name" => "Joe Bloggs", "Phone" => "88880000" }
          add = Client::Update[hash]
          expect(add[:Phone]).to eql("88880000")
        end
      end

      context "with an invalid Update schema" do
        it "should raise an error" do
          hash = { "Email" => "Joe Bloggs" }
          expect { Client::Update[hash] }.to raise_error(Dry::Types::ConstraintError, /ID is missing in Hash input/)
        end

        it "should raise an error on contacts" do
          hash = { "ID" => 25655881, "Name" => "Joe Bloggs Consulting", "Contacts" => [{ "Contact" => { "Email" => "Joe Bloggs" } }] }
          expect { Client::Update[hash] }.to raise_error(Dry::Types::ConstraintError, /Name is missing in Hash input/)
        end
      end
    end
  end
end
