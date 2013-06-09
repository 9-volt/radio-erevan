require 'spec_helper'

describe Parsers::Publika do
  describe '.fetch' do
    it 'parses the article properly' do
      result = Parsers::Publika.fetch(fixtures_path + '/publika_article.html')

      result.source.should == 'publika'
      result.category.should start_with('POLITIC')
      result.author.should == 'PUBLIKA.MD'
      result.title.should match /Retrospectiva/u
      result.sentences.should_not be_empty
    end
  end
end
