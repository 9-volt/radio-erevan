require 'spec_helper'

describe Parsers::Timpul do
  describe '.fetch' do
    it 'parses the article properly' do
      result = Parsers::Timpul.fetch(fixtures_path + '/timpul_article.html')

      result.source.should == 'timpul'
      result.category.should == 'Editorial'
      result.title.should match /sunt/u
      result.sentences.should_not be_empty
    end
  end
end
