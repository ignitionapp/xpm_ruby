require "spec_helper"

module XpmRuby
  module Schema
    RSpec.describe(Contact) do
      context "with a valid Add schema" do
        it "should not raise an error" do
          hash = {
            "Client" => { "ID" => 25655881 },
            "Name" => "Joe Bloggs" }
          expect { Contact::Add[hash] }.not_to raise_error
        end
      end

      context "with an invalid Add schema" do
        it "should raise an error" do
          hash = { "Name" => "Joe Bloggs" }
          expect { Contact::Add[hash] }.to raise_error(Dry::Types::ConstraintError, /Client is missing in Hash input/)
        end
      end
    end
  end
end
