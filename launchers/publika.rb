require_relative '../db_setup'

module Launchers end

class Launchers::Publika
  def self.launch
    puts 'Publika launcher starting'
    URL.all(source: 'publika', parsed: false, error: false).take(10).each do |url|
      ParsePublikaJob.perform_async(url.id)
      puts "Parsing Publika URL #{url.url}"
    end
  end
end
