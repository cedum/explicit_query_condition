require "bundler/setup"
require "explicit_query_condition"

require 'with_model'

RSpec.configure do |config|
  config.before :suite do
    ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
  end
  config.extend WithModel

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
