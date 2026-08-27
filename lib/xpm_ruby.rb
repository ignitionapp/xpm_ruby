module XpmRuby
  class Error < StandardError; end

  class ApiError < Error; end

  class UnknownError < Error; end

  class Unauthorized < Error; end

  class AccessTokenExpired < Unauthorized; end

  class Forbidden < Error; end

  class AuthenticationUnsuccessful < Forbidden; end

  class NotAvailable < Error; end

  class ConnectionFailed < Error; end

  class ConnectionTimeout < Error; end

  class InternalServerError < Error; end

  class RateLimitExceeded < Error
    attr_reader :details

    def initialize(message, details:)
      @details = details
      super(message)
    end
  end

  class << self
    # Called with a XpmRuby::RateLimits for every response that reports one, refused or not. Set it
    # once at boot:
    #
    #   XpmRuby.on_rate_limits = ->(limits) { MyApp.record(limits) }
    #
    # Every entry point in this gem builds its own Connection and never hands it back, so a reader
    # on the connection would be unreachable from a caller that only calls `Client.get`. A callback
    # reaches all of them — including the 429s that raise from inside a `rescue` somewhere and would
    # otherwise take an exception-carried payload with them.
    attr_accessor :on_rate_limits

    def notify_rate_limits(limits)
      callback = on_rate_limits
      return if callback.nil?

      callback.call(limits)
    rescue StandardError => error
      # A hook that only measures a budget must not be able to fail the request it was measuring:
      # a caller whose store is down would otherwise take every XPM call down with it. Warned
      # rather than swallowed, because silent is indistinguishable from a callback nobody wired up.
      warn("XpmRuby.on_rate_limits raised #{error.class}: #{error.message}")
    end
  end
end

require "active_support"
require "active_support/core_ext"
require "builder"

require "xpm_ruby/category"
require "xpm_ruby/client"
require "xpm_ruby/contact"
require "xpm_ruby/connection"
require "xpm_ruby/job"
require "xpm_ruby/rate_limits"

require "xpm_ruby/schema/client/add"
require "xpm_ruby/schema/client/update"
require "xpm_ruby/schema/contact/add"
require "xpm_ruby/schema/contact/update"
require "xpm_ruby/schema/job/add"
require "xpm_ruby/schema/job/applytemplate"
require "xpm_ruby/schema/job/delete"
require "xpm_ruby/schema/job/state"
require "xpm_ruby/schema/job/update"
require "xpm_ruby/schema/staff/add"
require "xpm_ruby/schema/staff/delete"
require "xpm_ruby/schema/staff/update"

require "xpm_ruby/staff"
require "xpm_ruby/template"
require "xpm_ruby/version"
