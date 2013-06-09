require 'open-uri'
require 'nokogiri'
require 'json'

class Parsers::Unimedia < Parsers::Base
  class << self
    def fetch(url)
      # The URL is a permalink that looks like http://unimedia.info/stiri/permalink-61799.html

      doc = get_page(url)

      true_sentences = parse_sentences(doc).map do |s|
        Parsers::Sentence.new(text: s)
      end

      Parsers::Article.new(time: parse_metadata(doc),
                           author: parse_author(doc),
                           url: url,
                           category: parse_category(doc),
                           title: parse_title(doc),
                           sentences: true_sentences)
    end

    private

      def get_page(url)
        Nokogiri::HTML(open url)
      end

      def parse_metadata(doc)
        metadata_container = doc.css('#content .left-container .news-details .white-v-separator')
        convert_time(metadata_container.children.first.text)
      end

      def parse_author(doc)
        doc.css('#content .display-block').text.match(/Autor: (?<author>.+)/)[:author]
      end

      def parse_category(doc)
        doc.css('#menu .actived').text
      end

      def parse_sentences(doc)
        doc.css('#content .news-text').text.split('.').map(&:strip)
      end

      def parse_title(doc)
        doc.css('#content .bigtitlex2').text
      end

      def convert_time(str)
        # converts the date from the format ora: 11:15, 09 iun 2013
        # into a proper ruby time object

        match_data = str.match(/ora: (?<hours>\d+):(?<minutes>\d+), (?<day>\d+) (?<month>\S+) (?<year>\d+)/)
        Time.new(match_data[:year],
                 convert_month(match_data[:month]),
                 match_data[:day],
                 match_data[:hours],
                 match_data[:minutes])
      end

      def convert_month(str)
        case str
        when 'ian' then 'jan'
        when 'mai' then 'may'
        when 'iun' then 'jun'
        when 'iul' then 'jul'
        when 'noi' then 'nov'
        else str
        end
      end
  end
end
