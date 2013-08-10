require 'open-uri'
require 'nokogiri'

# This thing takes the xmls from the JurnalTV rss and adds them to the database

class URLUpdaters::Jurnal
  class << self
    def update!
      puts "Updating Jurnal URLS"

      xml = open('http://jurnal.md/ro/rss.xml').read
      doc = Nokogiri::XML(xml)

      doc.css('link').map(&:text).uniq.each do |link|
        # create a link only if it has a digit in the url, so that random links from the RSS won't get in
        URL.create!(source: "jurnal", url: link) if link.match /\d/
      end
      # we're done!
      puts "WOOHOO!"
    end
  end
end
