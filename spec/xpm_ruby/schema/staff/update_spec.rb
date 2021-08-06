require "spec_helper"

module XpmRuby
  module Schema
    RSpec.describe(Staff) do
      context "with a valid Update schema" do
        it "should not raise an error" do
          hash = { "ID" => "S000123", "Name" => "Joe Bloggs", "Email" => "staff@foo.com" }
          expect { Staff::Update[hash] }.not_to raise_error
        end
      end

      context "with an invalid Update schema" do
        it "should raise an error" do
          hash = { "Name" => "joe Bloggs", "Email" => "staff@foo.com" }
          expect { Staff::Update[hash] }.to raise_error(Dry::Types::MissingKeyError, ":ID is missing in Hash input")
        end
      end
    end
  end
end
