require 'spec_helper'

describe Parsers::Protv do
  describe '.fetch' do
    it 'parses the article properly' do
      result = Parsers::Protv.fetch(fixtures_path + '/protv_article.html')

      result.time.should == Time.new(2013, 'aug', 10, 15, 26)
      result.source.should == 'protv'
      result.title.should match /Familie/u
      result.author.should == 'PRO TV'
      result.sentences.should_not be_empty
    end
  end
end
