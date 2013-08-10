require 'open-uri'
require 'nokogiri'

module URLUpdaters
  class Protv
    CATEGORIES = [:politic, :social, :economie, :sport, :divertisment,
                  :international]

    module SAVE_STATUS
      LINKS_SAVED = 1
      LINKS_PARTIALLY_SAVED = 2
    end

    class << self

      def update!
        CATEGORIES.each {|category| update_links_for_category!(category) }
      end

      def update_links_for_category! category, page=1
        puts "updating category #{category} page #{page}"

        document = Nokogiri::HTML(open(archive_page(category, page)))
        links = fetch_links document

        if links.any?
          status = save_links! links

          if status == SAVE_STATUS::LINKS_SAVED
            update_links_for_category! category, page + 1
          end
        end
      end

      def save_links! links
        puts "saving #{links.inspect}"

        already_saved_links = URL.all :conditions => ['url in ?', links]

        links.each {|url| URL.first_or_create :source => 'protv', :url => url }

        if already_saved_links.any?
          SAVE_STATUS::LINKS_PARTIALLY_SAVED
        else
          SAVE_STATUS::LINKS_SAVED
        end
      end

      def fetch_links document
        document.css('.numeStire a#navigare').map do |e|
          e.attributes['href'].value rescue nil
        end.compact
      end

      def archive_page (category, page=1)
        "http://protv.md/arhiva/#{category}/pagina-#{page}.html"
      end
    end
  end
end
