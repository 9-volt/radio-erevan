require 'sidekiq'
require_relative '../db_setup'
require 'lumberjack'

logger = Lumberjack::Logger.new("logs/sidekiq.log")

class ParseUnimediaJob
  include Sidekiq::Worker
  #sidekiq_options :queue => :unimedia_parsers

  def perform(url_id)
    url = URL.get(url_id)
    begin
      Fetchers::Unimedia.fetch(url)
    rescue Exception => e
      logger.error("BOOM! The URL was parsed in a wrong way!")
      logger.error(url)
      logger.error(e)
      url.update(error: true)
    end
  end
end
