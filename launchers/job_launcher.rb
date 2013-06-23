require_relative '../db_setup'

class JobLauncher
  def self.launch!
    URL.all(parsed: false, error: false).take(10).each do |url|
      ParseJob.perform_async(url.id)
      puts "Parsing URL #{url.url}"
    end
  end
end
