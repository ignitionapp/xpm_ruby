module XpmRuby
  class Error < StandardError; end

  class ApiError < Error; end

  class UnknownError < Error; end

  class Unauthorized < Error; end

  class AccessTokenExpired < Unauthorized; end

  class Forbidden < Error; end

  class NotAvailable < Error; end

  class ConnectionFailed < Error; end

  class ConnectionTimeout < Error; end

  class RateLimitExceeded < Error
    attr_reader :details

    def initialize(message, details:)
      @details = details
      super(message)
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
