require_relative '../parsers'

class ArticleFetcher
  class << self

    def fetch(url)
      article = find_parser(url).fetch(url.url)
      dump_article! article
      url.update(parsed: true)
    end

    # TODO: replace this with a proper message sent to the parser
    def find_parser(url)
      case url.url
      when /publika.md/         then Parsers::Publika
      when /unimedia.[info|md]/ then Parsers::Unimedia
      end
    end

    def dump_article!(article)
      a = Article.create(source:    article.source,
                         time:      article.time,
                         author:    article.author,
                         category:  article.category,
                         url:       article.url,
                         title:     article.title)

      article.sentences.each do |s|
        Sentence.create(text: s.text, article: a)
      end
    end
  end
end
