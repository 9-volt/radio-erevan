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
      def fetch(url)
        doc = get_page(url)

        true_sentences = parse_sentences(doc).map do |s|
          Parsers::Sentence.new(text: s)
        end

        Parsers::Article.new(source: self.name.split('::').last.downcase,
                             time: parse_metadata(doc),
                             author: parse_author(doc),
                             url: url,
                             category: parse_category(doc),
                             title: parse_title(doc),
                             sentences: true_sentences)
      end

      def get_page(url)
        Nokogiri::HTML(open url)
      end
    end
  end
end
