require "spec_helper"

module XpmRuby
  module Schema
    RSpec.describe(Contact) do
      context "with a valid Update schema" do
        it "should not raise an error" do
          hash = { "Name" => "Joe Bloggs" }
          expect { Contact::Update[hash] }.not_to raise_error
        end
      end
    end
  end
end
