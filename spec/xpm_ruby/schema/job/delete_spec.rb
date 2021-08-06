require "spec_helper"

module XpmRuby
  module Schema
    RSpec.describe(Job) do
      context "with a valid Delete schema" do
        it "should not raise an error" do
          hash = { "ID" => "J230498" }
          expect { Job::Delete[hash] }.not_to raise_error
        end
      end

      context "with an invalid Delete schema" do
        it "should raise an error" do
          hash = {}
          expect { Job::Delete[hash] }.to raise_error(Dry::Types::MissingKeyError, /ID is missing in Hash input/)
        end
      end
    end
  end
end
