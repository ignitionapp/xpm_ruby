require "spec_helper"

module XpmRuby
  module Schema
    RSpec.describe(Client) do
      context "with a valid Add schema" do
        context "with contacts" do
          it "should not raise an error" do
            hash = { "Name" => "Joe Bloggs Consulting", "Contacts" => [{ "Contact" => { "Name" => "Joe Bloggs" } }] }
            expect { XpmRuby::Schema::Client::Add[hash] }.not_to raise_error
          end
        end

        context "without contacts" do
          it "should not raise an error" do
            hash = { "Name" => "Joe Bloggs Consulting" }
            expect { XpmRuby::Schema::Client::Add[hash] }.not_to raise_error
          end
        end

        it "should coerce the types" do
          hash = { "Name" => "Joe Bloggs", "Phone" => "88880000" }
          add = XpmRuby::Schema::Client::Add[hash]
          expect(add[:Phone]).to eql("88880000")
        end
      end

      context "with an invalid Add schema" do
        it "should raise an error" do
          hash = { "Email" => "Joe Bloggs" }
          expect { XpmRuby::Schema::Client::Add[hash] }.to raise_error(Dry::Types::ConstraintError, /Name is missing in Hash input/)
        end

        it "should raise an error on contacts" do
          hash = { "Name" => "Joe Bloggs Consulting", "Contacts" => [{ "Contact" => { "Email" => "Joe Bloggs" } }] }
          expect { XpmRuby::Schema::Client::Add[hash] }.to raise_error(Dry::Types::ConstraintError, /Name is missing in Hash input/)
        end
      end
    end
  end
end
