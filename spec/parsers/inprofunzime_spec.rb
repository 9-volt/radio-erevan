require 'spec_helper'

describe Parsers::Inprofunzime do
  describe '.fetch' do
    it 'parses the article properly' do
      result = Parsers::Inprofunzime.fetch(fixtures_path + '/inprofunzime_article.html')

      result.time.should == Time.new(2013, 'jul', 9, 16, 59)
      result.source.should == 'inprofunzime'
      result.title.should match /Ashton/u
      result.author.should == 'PRO TV'
      result.category.should == 'Politic'
      result.sentences.should_not be_empty
    end
  end
end
