ENV['EREVAN_ENV'] ||= 'test'

require 'rspec'
require 'factory_girl'

require_relative '../db_setup'
require_relative 'factories/factories'
require_relative '../parsing/parsers'


def fixtures_path
  File.expand_path('spec/fixtures/')
end
