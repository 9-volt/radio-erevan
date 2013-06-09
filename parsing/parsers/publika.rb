require 'open-uri'
require 'nokogiri'
require 'json'

class Parsers::Publika < Parsers::Base
  class << self
    def fetch(url)
      doc = get_page(url)

      true_sentences = parse_sentences(doc).map do |s|
        Parsers::Sentence.new(text: s)
      end

      Parsers::Article.new(source: 'publika',
                           time: parse_metadata(doc),
                           author: parse_author(doc),
                           url: url,
                           category: parse_category(doc),
                           title: parse_title(doc),
                           sentences: true_sentences)
    end

    private

      def parse_metadata(doc)
        date = doc.css('div.articleInfo').text
        exp = /(?<day>\d+)-(?<month>\d+)-(?<year>\d+).*(?<hours>\d+):(?<minutes>\d+)/
        match_date = date.match exp

        Time.new(match_date[:year],
                 match_date[:month],
                 match_date[:day],
                 match_date[:hours],
                 match_date[:minutes])
      end

      def parse_author(doc)
        doc.css('div.articleInfo').children.css('a').first.text
      end

      def parse_category(doc)
        doc.css('div.pageHeader a.active').children.first.content.strip
      end

      def parse_sentences(doc)
        doc.css('div#articleLeftColumn p').text.split('.').map(&:strip)
      end

      def parse_title(doc)
        doc.css('div#articleLeftColumn h1').text
      end
  end
end
