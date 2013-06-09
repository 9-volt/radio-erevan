require_relative '../db_setup'

module Launchers end

class Launchers::Unimedia
  def self.launch
    puts 'Unimedia launcher starting'
    URL.all(source: 'unimedia', parsed: 'false').take(5).each do |url|
      ParseUnimediaJob.perform_async(url.id)
      puts "Parsing Unimedia URL #{url.url}"
    end
  end
end
