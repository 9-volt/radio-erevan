require 'open-uri'
require 'nokogiri'

module URLUpdaters
  class Timpul
    CATEGORIES = %w(1/actualitate/ 2/politica/ 3/economie/ 4/opinii--editoriale/ 61/international/ 5/cultura/ 6/timpul-liber/ 7/sport/)

    class << self

      def update!
        puts "Updating Timpul URLS"

        CATEGORIES.each { |category| update_links_for_category(category)}
      end

      def update_links_for_category category
        last_page = pages_count_for_each_category category

        (1..last_page).each do |page|
          sleep 5
          puts "Parsing page #{page}/#{last_page} from category: #{category.split('/').last}"
          doc = Nokogiri::HTML(open(archive_page(category, page)))
          links = fetch_links(doc)

          if links.any?
            return if save_links(links)
          end
        end
      end

      def save_links links
        already_saved_links = URL.all :conditions => ['url in ?', links]
        skip = already_saved_links.count == links.count

        puts "saving #{links.count} links"
        links.each {|url| URL.first_or_create :source => 'timpul', :url => url }

        return false if ENV['ALL']
        skip
      end

      def fetch_links document
        document.css('.boxStireTitleSmall a').map do |e|
          e.attributes['href'].value rescue nil
        end.compact.select do |link|
          link.start_with? '/'
        end.map do |link|
          "http://timpul.md#{link}"
        end
      end

      def pages_count_for_each_category category
        doc = Nokogiri::HTML(open(archive_page(category, 999999)))
        doc.css('.pag').css('.on').text.to_i
      end

      def archive_page category, page
        "http://timpul.md/rubrici/#{category}?p=#{page}"
      end
    end
  end
end
