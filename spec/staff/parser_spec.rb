require "spec_helper"

module XpmRuby
  module Staff
    RSpec.describe(Parser) do
      describe "#parse"
      context "when response status error" do
        let(:io) do StringIO.new(%{
          <Response>
            <Status>ERROR</Status>
            <ErrorDescription>A detailed explanation of the error</ErrorDescription>
          </Response>
          })
        end

        it "raises error" do
          expect(Parser.parse(io: io))
            .to raise_error(Parser::Error, "A detailed explanation of the error")
        end
      end

      context "when response status ok"
    end
  end
end
