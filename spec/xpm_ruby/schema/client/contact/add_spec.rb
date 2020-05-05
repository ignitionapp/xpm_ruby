require "spec_helper"

module XpmRuby
  module Schema
    module Client
      RSpec.describe(Contact) do
        context "with a valid Add schema" do
          it "should not raise an error" do
            hash = {
              "Client" => {
                "Id" => "" },
              "Name" => "Joe Bloggs" }
            expect { Contact::Add[hash] }.not_to raise_error
          end
        end

        context "with an invalid Add schema" do
          it "should raise an error" do
            hash = { "Email" => "Joe Bloggs" }
            expect { Client::Add[hash] }.to raise_error(Dry::Types::ConstraintError, /Name is missing in Hash input/)
          end
        end
      end
    end
  end
end
