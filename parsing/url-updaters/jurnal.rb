require 'open-uri'
require 'nokogiri'

# This thing takes the xmls from the JurnalTV rss and adds them to the database

class URLUpdaters::Jurnal
  class << self
    def update!
      puts "Updating Jurnal URLS"

      xml = open('http://jurnal.md/ro/rss.xml').read
      doc = Nokogiri::XML(xml)

      doc.css('link').uniq.each do |link|
        pp link
      end
      # we're done!
      puts "WOOHOO!"
    end
  end
end
