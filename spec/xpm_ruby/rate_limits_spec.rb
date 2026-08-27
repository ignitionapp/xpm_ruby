require "spec_helper"

module XpmRuby
  RSpec.describe(RateLimits) do
    def build(headers, status: 200, xero_tenant_id: "XERO_TENANT_ID")
      response = instance_double(Faraday::Response, status: status, headers: headers)

      RateLimits.from_response(response, xero_tenant_id: xero_tenant_id)
    end

    describe ".from_response" do
      it "parses the reported budgets as integers" do
        limits = build({
          "retry-after" => "22",
          "x-rate-limit-problem" => "minute",
          "x-minlimit-remaining" => "0",
          "x-daylimit-remaining" => "4539",
          "x-appminlimit-remaining" => "9938"
        })

        expect(limits.retry_after).to eq(22)
        expect(limits.problem).to eq("minute")
        expect(limits.minlimit_remaining).to eq(0)
        expect(limits.daylimit_remaining).to eq(4539)
        expect(limits.appminlimit_remaining).to eq(9938)
      end

      it "carries the status and tenant the reading came from" do
        limits = build({ "x-daylimit-remaining" => "10" }, status: 429, xero_tenant_id: "TENANT")

        expect(limits.status).to eq(429)
        expect(limits.xero_tenant_id).to eq("TENANT")
      end

      it "keeps the raw wire-named slice for RateLimitExceeded#details" do
        limits = build({
          "retry-after" => "22",
          "x-daylimit-remaining" => "0",
          "content-type" => "text/xml"
        })

        expect(limits.headers).to eq("retry-after" => "22", "x-daylimit-remaining" => "0")
      end

      # Faraday stores headers under the casing the server sent, and only `[]` on its Headers is
      # case-insensitive — `slice` is not. Xero sends these lowercase, so this is what the old
      # `slice` produced; the point of the spec is that a change of casing at Xero's end cannot
      # quietly empty the hash that `RateLimitExceeded#details` hands to callers.
      it "reads the reported headers whatever casing they arrived under" do
        %w[retry-after Retry-After RETRY-AFTER].each do |name|
          headers = Faraday::Utils::Headers.new
          headers[name] = "22"

          limits = build(headers)

          expect(limits.headers).to eq("retry-after" => "22")
          expect(limits.retry_after).to eq(22)
        end
      end

      # A remaining count of zero is the single most important reading there is: it is the one a
      # caller has to stop on. Absent has to stay distinguishable from it, which rules out `to_i`.
      it "reads an exhausted budget as zero and a missing one as nil" do
        exhausted = build({ "x-daylimit-remaining" => "0" })
        missing = build({})
        blank = build({ "x-daylimit-remaining" => "" })

        expect(exhausted.daylimit_remaining).to eq(0)
        expect(missing.daylimit_remaining).to be_nil
        expect(blank.daylimit_remaining).to be_nil
      end

      it "reads an unparseable budget as nil rather than zero" do
        limits = build({ "x-daylimit-remaining" => "unlimited" })

        expect(limits.daylimit_remaining).to be_nil
      end

      it "reads a blank problem as nil" do
        expect(build({ "x-rate-limit-problem" => "" }).problem).to be_nil
      end

      it "tolerates a response with no headers at all" do
        response = instance_double(Faraday::Response, status: 200, headers: nil)

        expect(RateLimits.from_response(response).headers).to eq({})
      end
    end

    describe "#empty?" do
      it "is true when the response named no limit" do
        expect(build({ "content-type" => "text/xml" })).to be_empty
      end

      it "is false when a budget is reported as exhausted" do
        expect(build({ "x-daylimit-remaining" => "0" })).not_to be_empty
      end

      it "is false when only the problem is named" do
        expect(build({ "x-rate-limit-problem" => "concurrent" })).not_to be_empty
      end
    end

    describe "#to_h" do
      it "reports the parsed fields alongside the reading's context" do
        limits = build({ "x-daylimit-remaining" => "0", "x-rate-limit-problem" => "day" }, status: 429)

        expect(limits.to_h).to eq(
          status: 429,
          xero_tenant_id: "XERO_TENANT_ID",
          problem: "day",
          retry_after: nil,
          minlimit_remaining: nil,
          daylimit_remaining: 0,
          appminlimit_remaining: nil
        )
      end
    end
  end
end
