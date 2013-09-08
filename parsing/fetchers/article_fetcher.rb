require_relative '../parsers'

class ArticleFetcher
  class << self

    def fetch(url)
      article = find_parser(url).fetch(url.url)
      dump_article! article
      url.update(parsed: true)
    end

    def find_parser(url)
      Parsers.const_get(url.source.capitalize.to_sym)
    end

    def dump_article!(article)
      a = Article.create!(source:    article.source,
                         time:      article.time,
                         author:    article.author.strip,
                         category:  article.category.strip,
                         url:       article.url.strip,
                         title:     article.title.strip)

      article.sentences.each do |s|
        Sentence.create(text: s.text, article: a)
      end
    end
  end
end
