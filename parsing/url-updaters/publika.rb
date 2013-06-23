require 'open-uri'
require 'nokogiri'

# This thing goes to the Publika page, looks at the latest news story's permalink
# and updates the database of URLS accordingly

class URLUpdaters::Publika
  class << self

    def update!
      puts "Updating Publika URLS"
      # get the ID of the last URL in the database
      # we don't care if it's parsed or not, we just need to update the DB of URLS
      last_url = URL.last(source: "publika") || NilURL.new
      p last_url

      # let's get the permalink id of that
      last_permalink_id = last_url.url.match(/\d+/)[0].to_i

      puts "Our last permalink ID: #{last_permalink_id}"

      # be wary of the fact that as far as we observed, Publika
      # has all the permalinks ending in 1. Therefore,
      # we have 10 times less stuff to parse!

      last_title_id = find_last_title_id

      puts "Their last permalink ID: #{last_title_id}"
      need_to_add = (last_title_id - last_permalink_id) / 10
      puts "Need to add #{need_to_add} URLs"


      last_permalink_id.step(last_title_id, 10).each do |id|
        puts "Creating URLs: #{(id - last_permalink_id) / 10} / #{need_to_add}"

        url_string = "http://www.publika.md/article_#{id}.html"
        URL.create(source: "publika", url: url_string)
      end

      # we're done!
      puts "WOOHOO!"
    end

    def find_last_title_id
      puts "Opening the Publika page..."

      doc = Nokogiri::HTML(open 'http://www.publika.md/toate-stirile')

      doc.css('.newsTitle a').first
         .attributes["href"].value
         .match(/\d+/)[0].to_i
    end
  end
end

class NilURL
  def url
    'http://www.publika.md/article_531.html'
  end
end
