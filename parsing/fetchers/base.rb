require_relative '../parsers'

module Fetchers end

class Fetchers::Base
  def self.dump_article!(article)
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
