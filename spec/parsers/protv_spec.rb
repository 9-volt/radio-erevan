require 'spec_helper'

#Na samom dele linkurile is de pe inprofunzime :/
describe Parsers::Protv do
  describe '.fetch' do
    it 'parses the article properly' do
      result = Parsers::Protv.fetch(fixtures_path + '/protv_article.html')

      result.time = Time.new(2013, 'jul', 9, 16, 42)
      result.source.should == 'protv'
      result.title.should match /Ashton/u
      result.author.should == 'PRO TV'
      result.category.should == 'Politic'
      result.sentences.should_not be_empty
    end
  end
end
