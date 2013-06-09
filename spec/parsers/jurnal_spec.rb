require 'spec_helper'

describe Parsers::Jurnal do
  describe '.fetch' do
    it 'parses the article properly' do
      result = Parsers::Jurnal.fetch(fixtures_path + '/jurnal_article.html')

      result.source.should == 'jurnal'
      result.category.should == 'Politic'
      result.author.should == 'Ion Buraga'
      result.title.should match /Scrisorile/u
      result.sentences.should_not be_empty
    end
  end
end
