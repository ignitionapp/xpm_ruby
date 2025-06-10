require "bundler/setup"
require "xpm_ruby"
require "vcr"
require "dotenv/load"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with(:rspec) do |c|
    c.syntax = :expect
  end

  # Shared example group for Xero credentials
  config.shared_context_metadata_behavior = :apply_to_host_groups

  RSpec.shared_context "xero credentials" do
    let(:xero_tenant_id) do
      ENV.fetch("XERO_TENANT_ID") do
        raise "XERO_TENANT_ID environment variable is required. Please add it to your .env file"
      end
    end

    let(:access_token) do
      ENV.fetch("XERO_ACCESS_TOKEN") do
        raise "XERO_ACCESS_TOKEN environment variable is required. Please add it to your .env file"
      end
    end
  end
end

VCR.configure do |config|
  config.default_cassette_options = { record: :new_episodes }

  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into(:faraday)
end
