task :console do
  require 'irb'
  require_relative "./db_setup"

  puts "Radio Erevean on the line, speak your mind!"

  ARGV.clear
  IRB.start
end

task :populate_urls do
  require_relative "./db_setup"

  puts "Populating Unimedia URLs..."
  60000.times do |t|
    id = t+1
    article_url = "unimedia.info/stiri/permalink-#{id}.html"
    URL.create(url: article_url, source: 'unimedia')
    puts "#{id} => #{article_url}"
  end
end
