require 'virtus'

class ParserError < StandardError
end

module Parsers

  class Sentence
    include Virtus

    attribute :text, String
  end

  class Article
    include Virtus

    attribute :source,    String
    attribute :time,      Time
    attribute :author,    String
    attribute :url,       String
    attribute :category,  String
    attribute :title,     String
    attribute :sentences, Array[Sentence]
  end

  class Base
    class << self
      def get_page(url)
        Nokogiri::HTML(open url)
      end

      def fetch
        raise ParserError.new('Parser not yet implemented')
      end
    end
  end
end
