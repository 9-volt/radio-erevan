require 'open-uri'
require 'nokogiri'

module URLGenerators
end

class URLGenerators::Unimedia
  class << self
    attr_accessor :article_urls

    def update
    end

    def load(str)
      @article_urls = str.split("\n").map(&:strip)
    end

    def save
    end

    def all
      article_urls
    end

    private
      def article_urls
        @article_urls.nil? ? [] : @article_urls
      end
  end
end
