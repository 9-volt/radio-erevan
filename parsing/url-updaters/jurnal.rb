require 'open-uri'
require 'nokogiri'

# This thing takes the xmls from the JurnalTV rss and adds them to the database

class URLUpdaters::Jurnal
  class << self
    def update!
      puts "Updating Jurnal URLS"

      xml = open('http://jurnal.md/ro/rss.xml').read
      doc = Nokogiri::XML(xml)

      links = doc.css('link').map(&:text).uniq
      success = 0

      links.each do |link|
        # create a link only if it has a digit in the url,
        # so that random links from the RSS won't get in

        if link.match /\d/
          success == 1 if URL.create(source: "jurnal", url: link)
        end
      end
      # we're done!
      p "Imported #{success} out of #{links.count}"
    end
  end
end
