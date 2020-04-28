module XpmRuby
  class Error < StandardError; end
  class Unauthorized < Error; end
end

require "active_support/core_ext/string/inflections"
require "active_support/core_ext/hash/keys"
require "xpm_ruby/connection"
require "xpm_ruby/job"
require "xpm_ruby/staff"
require "xpm_ruby/template"
require "xpm_ruby/version"
