task :console do
  require 'irb'
  require_relative "app"
  require_relative "dashboard/dash"

  puts "Radio Erevean on the line, speak your mind!"

  ARGV.clear
  IRB.start
end

namespace :update_urls do
  require_relative "app"

  task :unimedia do
    URLUpdaters::Unimedia.update!
  end

  task :timpul do
    URLUpdaters::Timpul.update!
  end

  task :publika do
    URLUpdaters::Publika.update!
  end

  task :jurnal do
    URLUpdaters::Jurnal.update!
  end

  task :protv do
    URLUpdaters::Protv.update!
  end
end

namespace :fetch do
  require_relative "app"
  task :everything do
    JobLauncher.launch!
  end
end
