require "spec_helper"

module XpmRuby
  module Schema
    RSpec.describe(Job) do
      context "with a valid Applytemplate schema" do
        it "should not raise an error" do
          hash = { "ID" => "J230498", "TemplateID" => 1234, "TaskMode" => "AddNew" }
          expect { Job::Applytemplate[hash] }.not_to raise_error
        end

        it "should coerce the types" do
          hash = { "ID" => "J230498", "TemplateID" => 1234, "TaskMode" => "AddNew" }
          applytemplate = Job::Applytemplate[hash]
          expect(applytemplate[:TemplateID]).to eql("1234")
        end
      end

      context "with an invalid Applytemplate schema" do
        it "should raise an error" do
          hash = { "TemplateID" => 1234, "TaskMode" => "AddNew" }
          expect { Job::Applytemplate[hash] }.to raise_error(Dry::Types::ConstraintError, /ID is missing in Hash input/)
        end
      end
    end
  end
end
