require "spec_helper"

module XpmRuby
  module Schema
    RSpec.describe(Staff) do
      context "with a valid Add schema" do
        it "should not raise an error" do
          hash = { "Name" => "Joe Bloggs", "Email" => "staff@foo.com" }
          expect { Staff::Add[hash] }.not_to raise_error
        end
      end

      context "with an invalid Add schema" do
        it "should raise an error" do
          hash = { "Email" => "staff@foo.com" }
          expect { Staff::Add[hash] }.to raise_error(Dry::Types::MissingKeyError, ':Name is missing in Hash input')
        end
      end
    end
  end
end
