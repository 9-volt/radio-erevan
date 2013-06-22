require_relative '../parsers'

module Fetchers end

class Fetchers::Unimedia
  def self.fetch(url)
    unless url.parsed?
      article = Parsers::Unimedia.fetch(url.url)
      a = Article.create(source:    article.source,
                         time:      article.time,
                         author:    article.author,
                         category:  article.category,
                         url:       article.url,
                         title:     article.title)

      article.sentences.each do |s|
        Sentence.create(text: s.text, article: a)
      end

      url.update(parsed: true)
    end
  end
end

