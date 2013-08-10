class Parsers::Protv < Parsers::Base
  class << self
    def parse_metadata doc
      convert_time doc.css('.boxStire .boxTime').children.first.text
    end

    def parse_author doc
      doc.css('.articleSource').text
    end

    def parse_category(doc)
      @url.split('/')[1]
    end

    def parse_sentences(doc)
      doc.css('.continut').children.map(&:text).map {|s| s.split('.')}
         .flatten.map(&:strip).select {|s| s.size > 1 }
    end

    def parse_title(doc)
      doc.css('title').text
    end

    def convert_time str
      match_data = str.match(/(?<hours>\d+):(?<minutes>\d+), (?<day>\d+) (?<month>\S+) (?<year>\d+)/)
      Time.new(match_data[:year],
               convert_month(match_data[:month][0..2].downcase),
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
