task :console do
  require 'irb'
  require_relative "./db_setup"

  puts "Radio Erevean on the line, speak your mind!"

  ARGV.clear
  IRB.start
end

namespace :update_urls do
  require_relative "./db_setup"
  task :unimedia do
    URLUpdaters::Unimedia.update!
  end
  task :publika do
    URLUpdaters::Publika.update!
  end
end

namespace :fetch do
  require_relative "./db_setup"
  task :everything do
    JobLauncher.launch!
  end
end
