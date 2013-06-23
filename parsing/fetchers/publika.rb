require_relative '../parsers'

module Fetchers end

class Fetchers::Publika < Fetchers::Base
  def self.fetch(url)
    unless url.parsed?
      p "Parsing publika URL #{url.url}"
      article = Parsers::Publika.fetch(url.url)
      dump_article! article
      url.update(parsed: true)
    end
  end
end

