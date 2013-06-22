require 'open-uri'
require 'nokogiri'

module URLUpdaters
end

# This thing goes to the Unimedia page, looks at the latest news story's permalink
# and updates the database of URLS accordingly
#
# P.S. Unimedia is easy. We'll see how we deal with jurnal

class URLUpdaters::Unimedia
  class << self

    def update!
      puts "Updating Unimedia URLS"
      # get the ID of the last URL in the database
      # we don't care if it's parsed or not, we just need to update the DB of URLS
      last_url = URL.last(source: "unimedia") || NilURL.new
      p last_url

      # let's get the permalink id of that
      last_permalink_id = last_url.url.match(/\d+/)[0].to_i

      puts "Our last permalink ID: #{last_permalink_id}"

      # good, we have something like 34567, which is the last article URL
      # that we have in our database. We now need to find what's the latest
      # on the page.

      last_title_id = find_last_title_id

      puts "Their last permalink ID: #{last_title_id}"
      need_to_add = last_title_id - last_permalink_id
      puts "Need to add #{need_to_add} URLs"

      # now we go from our last to their last ids and dump URL objects into the DB

      ((last_permalink_id + 1)..last_title_id).each do |id| # TODO: refactor this
        # woohoo! create URLs
        puts "Creating URLs: #{id - last_permalink_id} / #{need_to_add}"

        url_string = "http://www.unimedia.info/stiri/permalink-#{id}.html"
        URL.create(source: "unimedia", url: url_string)
      end

      # we're done!
      puts "WOOHOO!"
    end

    def find_last_title_id
      puts "Opening the Unimedia page..."

      doc = Nokogiri::HTML(open 'http://unimedia.info/')
      doc.css('a.bigtitle').first       # this is a Nokogiri href
         .attributes["href"].value      # ok, we got the permalink URL
         .match(/\d+/)[0].to_i          # ae, obtain something like 45678
    end
  end
end

class NilURL
  def url
    'unimedia.info/stiri/permalink-1.html'
  end
end
