require 'open-uri'
require 'nokogiri'
require 'json'

class Parsers::Jurnal < Parsers::Base
  class << self
    def fetch(url)
      # http://jurnal.md/ro/news/scrisorile-lui-buraga-lupu-ca-ou-1151985/
      doc = get_page(url)

      true_sentences = parse_sentences(doc).map do |s|
        Parsers::Sentence.new(text: s)
      end

      Parsers::Article.new(source: 'jurnal',
                           time: parse_metadata(doc),
                           author: parse_author(doc),
                           url: url,
                           category: parse_category(doc),
                           title: parse_title(doc),
                           sentences: true_sentences)
    end

    private

      def parse_metadata(doc)
        date = doc.css('tr.bg_a1 td.lpadd10 span').text
        time = doc.css('tr.bg_a1 td.rpadd10 span').text

        match_date = date.match(/(?<day>\d+) (?<month>\S+) (?<year>\d+)/)
        match_time = time.match(/(?<hours>\d+):(?<minutes>\d+)/)

        Time.new(match_date[:year],
                 match_date[:month],
                 match_date[:day],
                 match_time[:hours],
                 match_time[:minutes])
      end

      def parse_author(doc)
        element = doc.css('#news_block tr td strong').last
        if not element
          ''
        else
          element.text.split(' ')[-2..-1].join(' ')
        end
      end

      def parse_category(doc)
        doc.css('a.menu1.bold').text
      end

      def parse_sentences(doc)
        doc.css('#news_block tr td').first.text.split('.').map(&:strip)
      end

      def parse_title(doc)
        doc.css('title').text
      end
  end
end
