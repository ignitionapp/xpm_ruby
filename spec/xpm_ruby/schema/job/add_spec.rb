require "spec_helper"

module XpmRuby
  module Schema
    RSpec.describe(Job) do
      context "with a valid Add schema" do
        it "should not raise an error" do
          hash = { "Name" => "Joe Bloggs", "Description" => "New Job", "ClientID" => 1234, "StartDate" => 20091023, "DueDate" => 20091023 }
          expect { Job::Add[hash] }.not_to raise_error
        end

        it "should coerce the types" do
          hash = { "Name" => "Joe Bloggs", "Description" => "New Job", "ClientID" => 1234, "StartDate" => 20091023, "DueDate" => 20091023 }
          add = Job::Add[hash]
          expect(add[:ClientID]).to eql("1234")
        end
      end

      context "with an invalid Add schema" do
        it "should raise an error" do
          hash = { "Name" => "Joe Bloggs" }
          expect { Job::Add[hash] }.to raise_error(Dry::Types::ConstraintError, '{"Name"=>"Joe Bloggs"} violates constraints (:Description is missing in Hash input failed)')
        end
      end
    end
  end
end
