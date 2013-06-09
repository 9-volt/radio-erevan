require 'sidekiq'
require_relative '../db_setup'

class ParseUnimediaJob
  include Sidekiq::Worker
  sidekiq_options :queue => :unimedia_parsers

  def perform(url_id)
    url = URL.get(url_id)
    Fetchers::Unimedia.fetch(url)
  end
end
