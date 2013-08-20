require 'clockwork'
require_relative 'app'

include Clockwork

handler do |job|
  puts "Running #{job}"
end

every(10.seconds, 'Fetch one article from each of the sources') do
  JobLauncher.launch!
end

evry(10.hours, 'Sync all the URLs') do
  URLUpdaters::Unimedia.update!
  URLUpdaters::Publika.update!
  URLUpdaters::Protv.update!
  URLUpdaters::Jurnal.update!
  URLUpdaters::Timpul.update!
end


