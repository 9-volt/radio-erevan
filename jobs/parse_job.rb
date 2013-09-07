require 'sidekiq'
require_relative '../db_setup'
require 'lumberjack'


class ParseJob
  include Sidekiq::Worker
  logger = Lumberjack::Logger.new("logs/sidekiq.log")

  def perform(url_id)
    url = URL.get(url_id)
    begin
      puts "ParseJob | Trying to parse: #{url.url}"
      ArticleFetcher.fetch(url)
      puts "ParseJob | Parsed! #{url.url}"
    rescue Exception => e
      logger.error(url.url)
      logger.error(e)
      puts e
      url.update(error: true)
    end
  end
end
