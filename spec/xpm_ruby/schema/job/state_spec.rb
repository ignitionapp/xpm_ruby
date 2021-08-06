require "spec_helper"

module XpmRuby
  module Schema
    RSpec.describe(Job) do
      context "with a valid State schema" do
        it "should not raise an error" do
          hash = { "ID" => "J230498", "State" => "CONFIRMED" }
          expect { Job::State[hash] }.not_to raise_error
        end
      end

      context "with an invalid State schema" do
        it "should raise an error" do
          hash = { "ID" => "J230498" }
          expect { Job::State[hash] }.to raise_error(Dry::Types::MissingKeyError, /State is missing in Hash input/)
        end
      end
    end
  end
end
