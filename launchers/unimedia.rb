require_relative '../db_setup'

module Launchers end

class Launchers::Unimedia
  def self.launch
    URL.all(source: 'unimedia', parsed: 'false').each do |url|
      UnimediaParserJob.perform_async(url.id)
    end
  end
end
