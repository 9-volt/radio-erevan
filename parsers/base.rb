class ParserError::StandardError

module Parsers

  class Sentence
    include Virtus

    attribute :text, String
  end

  class Article
    include Virtus

    attribute :time,      Time
    attribute :author,    String
    attribute :url,       String
    attribute :category,  String
    attribute :title,     String
    attribute :sentences, Array[Sentence]
  end

  class Base
    class << self
      def fetch
        raise ParserError.new('Parser not yet implemented')
      end
    end
  end
end
