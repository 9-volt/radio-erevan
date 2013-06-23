require_relative '../parsers'

module Fetchers end

class Fetchers::Unimedia < Fetchers::Base
  def self.fetch(url)
    unless url.parsed?
      article = Parsers::Unimedia.fetch(url.url)
      dump_article! article
      url.update(parsed: true)
    end
  end
end

