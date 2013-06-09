require 'rubygems'
require 'data_mapper' # requires all the gems listed above

DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'postgres://postgres:postgres@localhost/erevan')

#require all models
Dir[File.dirname(__FILE__) + "/models/*.rb"].each {|f| require f }

#finalize
DataMapper.finalize
DataMapper.auto_upgrade!

#require other classes
require_relative './services/racai.rb'
