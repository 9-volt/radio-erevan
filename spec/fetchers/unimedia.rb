require 'spec_helper'

describe Fetchers::Unimedia do
  let!(:url) { FactoryGirl.create(:url) }

  describe '.fetch' do
    it 'takes a url from the database and records an article with it' do
      expect { Fetchers::Unimedia.fetch(url) }.to change { Article.count }.from(0).to(1)
      article = Article.first
      article.sentences.size.should be > 4
      url.should be_parsed
    end
  end

end
