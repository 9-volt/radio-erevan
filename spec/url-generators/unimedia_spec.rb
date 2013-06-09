require 'spec_helper'

describe URLGenerators::Unimedia do
  describe '.load' do
    let(:str) do <<-DATA
        http://unimedia.info/stiri/permalink-61797.html
        http://unimedia.info/stiri/permalink-61798.html
        http://unimedia.info/stiri/permalink-61799.html
      DATA
    end

    it 'properly loads the URLs' do
      URLGenerators::Unimedia.all.should be_empty
      URLGenerators::Unimedia.load(str)
      URLGenerators::Unimedia.all.length.should == 3
    end
  end
end
