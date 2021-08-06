require "spec_helper"

module XpmRuby
  module Schema
    RSpec.describe(Job) do
      context "with a valid Update schema" do
        it "should not raise an error" do
          hash = { "ID" => "J230498", "Name" => "Joe Bloggs", "Description" => "New Job", "ClientID" => 1234, "StartDate" => 20091023, "DueDate" => 20091023 }
          expect { Job::Update[hash] }.not_to raise_error
        end

        it "should coerce the types" do
          hash = { "ID" => "J230498", "Name" => "Joe Bloggs", "Description" => "New Job", "ClientID" => 1234, "StartDate" => 20091023, "DueDate" => 20091023 }
          add = Job::Update[hash]
          expect(add[:ClientID]).to eql("1234")
        end
      end

      context "with an invalid Update schema" do
        it "should raise an error" do
          hash = { "Name" => "Joe Bloggs", "Description" => "New Job", "ClientID" => 1234, "StartDate" => 20091023, "DueDate" => 20091023 }
          expect { Job::Update[hash] }.to raise_error(Dry::Types::MissingKeyError, /ID is missing in Hash input/)
        end
      end
    end
  end
end
