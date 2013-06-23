require 'sidekiq'
require_relative '../db_setup'
require 'lumberjack'


class ParseJob
  include Sidekiq::Worker
  logger = Lumberjack::Logger.new("logs/sidekiq.log")

  def perform(url_id)
    url = URL.get(url_id)
    begin
      ArticleFetcher.fetch(url)
      p "Properly fetched #{url.url}"
    rescue Exception => e
      logger.error(url)
      logger.error(e)
      url.update(error: true)
    end
  end
end
