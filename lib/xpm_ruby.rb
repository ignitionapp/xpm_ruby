module XpmRuby
  class Error < StandardError; end
  class Unauthorized < Error; end
end

require "nokogiri"

require "xpm_ruby/version"
require "xpm_ruby/connection"
require "xpm_ruby/job"
require "xpm_ruby/staff"
require "xpm_ruby/client"
require "xpm_ruby/template"
require "xpm_ruby/version"
