ENV['EREVAN_ENV'] ||= 'development'
require 'data_mapper'
require 'dm-timestamps'

#DataMapper::Logger.new($stdout, :debug)
case ENV['EREVAN_ENV'].to_sym
when :test
  DataMapper.setup(:default, 'sqlite::memory:')
else
  DataMapper.setup(:default, 'postgres://postgres:postgres@localhost/erevan')
end

#require everything!
Dir[File.dirname(__FILE__) + "/models/*.rb"].each {|f| require f }

#finalize
DataMapper.finalize
DataMapper.auto_upgrade!
