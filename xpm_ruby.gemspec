require_relative "lib/xpm_ruby/version"

Gem::Specification.new do |spec|
  spec.name          = "xpm_ruby"
  spec.version       = XpmRuby::VERSION
  spec.authors       = ["abreckner"]
  spec.email         = ["skuunk@gmail.com"]

  spec.summary       = "Ruby gem for accessing the XPM API"
  spec.homepage      = "https://github.com/ignitionapp/xpm_ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.1.3")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ignitionapp/xpm_ruby"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency("bundler")
  spec.add_development_dependency("rake")
  spec.add_development_dependency("rspec")

  spec.add_development_dependency("rubocop")
  spec.add_development_dependency("rubocop-rspec")

  spec.add_development_dependency("byebug", "~> 11")
  spec.add_development_dependency("pry-byebug", "~> 3")
  spec.add_development_dependency("vcr")

  spec.add_runtime_dependency("faraday")
  spec.add_runtime_dependency("faraday-encoding")
  spec.add_runtime_dependency("ox", "~> 2.13")

  spec.add_runtime_dependency("activesupport")
  spec.add_runtime_dependency("builder")

  spec.add_runtime_dependency("dry-types")
end
