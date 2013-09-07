require_relative '../db_setup'

class JobLauncher
  QUEUE = Sidekiq::Queue.new

  def self.url_scheduled? id
    QUEUE.any? {|job| job.args.first == id }
  end

  def self.launch!
    sources = %w(unimedia publika jurnal protv timpul)
    sources.each do |source|
      URL.all(parsed: false, source: source, error: false).take(1).each do |url|
        if url_scheduled? url.id
          puts "Url #{url.url} is already scheduled for parsing"
        else
          puts "Scheduling #{url.url}"
          ParseJob.perform_async(url.id)
        end
      end
    end
  end
end
