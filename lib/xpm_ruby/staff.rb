require "faraday"
require "base64"
require "ox"

require_relative "staff/model"
require_relative "staff/sax_parser"

module XpmRuby
  module Staff
    extend self

    def build(**test)
      Model.new(test)
    end

    def list(api_key:, account_key:)
      key = Base64.strict_encode64("#{api_key}:#{account_key}")

      http_response = Faraday
        .new(
          url: "https://api.workflowmax.com/v3",
          headers: { "Authorization" => "Basic #{key}" })
        .get("staff.api/list")

      io = StringIO.new(http_response.body)
      sax_parser = SaxParser.new
      Ox.sax_parse(sax_parser, io)

      sax_parser.staff_list
    end
  end
end
