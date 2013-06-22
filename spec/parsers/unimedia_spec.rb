require 'spec_helper'

describe Parsers::Unimedia do
  describe '.fetch' do
    it 'parses the article properly' do
      result = Parsers::Unimedia.fetch(fixtures_path + '/unimedia_article-1.html')

      result.source.should == 'unimedia'
      result.category.should == 'Politic'
      result.title.should match /Tănase/u
      result.sentences.should_not be_empty
    end
  end
end
