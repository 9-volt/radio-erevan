require 'spec_helper'

describe URLUpdaters::Unimedia do
  let!(:url) { FactoryGirl.create(:url) }

  describe ".update!" do
    it 'updates the database with a the URLs obtained from the front page' do
      URLUpdaters::Unimedia.should_receive(:find_last_title_id).and_return(3)
      URLUpdaters::Unimedia.update!

      URL.count.should == 3
      URL.last.source.should == "unimedia"
      URL.last.url.should == "http://www.unimedia.info/stiri/permalink-3.html"
    end
  end
end
