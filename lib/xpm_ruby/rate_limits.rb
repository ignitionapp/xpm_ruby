module XpmRuby
  # Xero returns its rate-limit headers on every XPM response, not only on the 429 that refuses one.
  # Read from the 429 alone they can only ever say the budget is already gone, which is too late to
  # pace against: the caller learns it is locked out at the moment it is locked out. Read from every
  # response they let a caller watch a budget drain while its requests are still succeeding, and
  # stop short of the limit instead of discovering it.
  class RateLimits
    RETRY_AFTER_HEADER           = "retry-after".freeze
    PROBLEM_HEADER               = "x-rate-limit-problem".freeze
    MINLIMIT_REMAINING_HEADER    = "x-minlimit-remaining".freeze
    DAYLIMIT_REMAINING_HEADER    = "x-daylimit-remaining".freeze
    APPMINLIMIT_REMAINING_HEADER = "x-appminlimit-remaining".freeze

    # Order matters only in that `RateLimitExceeded#details` has always carried this slice under
    # these wire names, and callers read it by those names.
    HEADERS = [
      RETRY_AFTER_HEADER,
      PROBLEM_HEADER,
      MINLIMIT_REMAINING_HEADER,
      DAYLIMIT_REMAINING_HEADER,
      APPMINLIMIT_REMAINING_HEADER
    ].freeze

    REPORTED_FIELDS = [
      :problem,
      :retry_after,
      :minlimit_remaining,
      :daylimit_remaining,
      :appminlimit_remaining
    ].freeze

    attr_reader :status,
      :xero_tenant_id,
      :headers,
      :problem,
      :retry_after,
      :minlimit_remaining,
      :daylimit_remaining,
      :appminlimit_remaining

    def self.from_response(response, xero_tenant_id: nil)
      headers = response.headers || {}

      new(
        status:                 response.status,
        xero_tenant_id:         xero_tenant_id,
        headers:                reported_headers(headers),
        problem:                headers[PROBLEM_HEADER].presence,
        retry_after:            integer(headers[RETRY_AFTER_HEADER]),
        minlimit_remaining:     integer(headers[MINLIMIT_REMAINING_HEADER]),
        daylimit_remaining:     integer(headers[DAYLIMIT_REMAINING_HEADER]),
        appminlimit_remaining:  integer(headers[APPMINLIMIT_REMAINING_HEADER])
      )
    end

    # The wire-named hash `RateLimitExceeded#details` has always carried. Built through `[]` rather
    # than `slice`, because on a Faraday::Utils::Headers only `[]` is case-insensitive: `slice`
    # compares keys exactly, so a `Retry-After` would leave `details` empty and a caller reading it
    # would fall back silently, as though Xero had never named a delay at all. Xero sends these
    # lowercase — HTTP/2 requires it — so for today's traffic this is the same hash as the slice it
    # replaces, down to the key order.
    def self.reported_headers(headers)
      HEADERS.each_with_object({}) do |name, reported|
        value = headers[name]

        reported[name] = value unless value.nil?
      end
    end
    private_class_method(:reported_headers)

    # `to_i` would read a missing or unparseable header as `0`. For a remaining-budget count that is
    # not "unknown" but "exhausted", so a caller gating on it would refuse every request off a
    # response that never mentioned a budget at all. Absent stays absent.
    def self.integer(value)
      Integer(value, exception: false)
    end
    private_class_method(:integer)

    def initialize(status:, xero_tenant_id:, headers:, problem:, retry_after:, minlimit_remaining:, daylimit_remaining:, appminlimit_remaining:)
      @status = status
      @xero_tenant_id = xero_tenant_id
      @headers = headers
      @problem = problem
      @retry_after = retry_after
      @minlimit_remaining = minlimit_remaining
      @daylimit_remaining = daylimit_remaining
      @appminlimit_remaining = appminlimit_remaining
    end

    # A response that names no limit at all. Distinct from a response reporting a budget of zero,
    # which is the most important reading there is.
    def empty?
      REPORTED_FIELDS.all? { |field| public_send(field).nil? }
    end

    def to_h
      REPORTED_FIELDS
        .each_with_object({ status: status, xero_tenant_id: xero_tenant_id }) do |field, fields|
          fields[field] = public_send(field)
        end
    end
  end
end
