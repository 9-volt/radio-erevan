require 'rspec'
require 'factory_girl'
require 'database_cleaner'

require_relative '../db_setup'
require_relative 'factories/factories'
require_relative '../parsing/parsers'


def fixtures_path
  File.expand_path('spec/fixtures/')
end

RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
