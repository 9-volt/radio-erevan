require_relative '../db_setup'

class JobLauncher
  def self.launch!
    sources = %w(unimedia publika)
    sources.each do |source|
      URL.all(parsed: false, source: source, error: false).take(10).each do |url|
        ParseJob.perform_async(url.id)
        puts "Parsing URL #{url.url}"
      end
    end
  end
end
