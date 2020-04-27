module XpmRuby
  class Error < StandardError; end
  class Unauthorized < Error; end
end

require "xpm_ruby/version"
require "xpm_ruby/connection"
require "xpm_ruby/staff"
require "xpm_ruby/client"
