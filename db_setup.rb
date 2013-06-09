require 'data_mapper'

#DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, 'postgres://postgres:postgres@localhost/erevan')

#require everything!
Dir[File.dirname(__FILE__) + "/models/*.rb"].each {|f| require f }

#require jobs
Dir[File.dirname(__FILE__) + "/jobs/*.rb"].each {|f| require f }

#require launchers
Dir[File.dirname(__FILE__) + "/launchers/*.rb"].each {|f| require f }

#finalize
DataMapper.finalize
DataMapper.auto_upgrade!

require_relative 'parsing/parsers'
