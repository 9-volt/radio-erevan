task :console do
  require 'irb'
  require_relative "./db_setup"

  puts "Radio Erevean on the line, speak your mind!"

  ARGV.clear
  IRB.start
end

namespace :update_urls do
  task :unimedia do
    require_relative "./db_setup"
    URLUpdaters::Unimedia.update!
  end
end

namespace :fetch do
  require_relative "./db_setup"
  task :unimedia do
    Launchers::Unimedia.launch
  end
end
