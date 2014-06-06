require 'rails_helper'
 
describe AdPlatform do

  describe 'mass assignment' do 
    [:name, :url].each do |e|
      it { should allow_mass_assignment_of(e) }
    end
  end

  describe 'validations' do
    [:name, :url, :user_id].each do |e|
      it { should validate_presence_of(e) }
    end
  end

  describe "associations" do
    it { should belong_to(:user) }
    it { should have_many(:bars) }
  end

  describe 'callbacks' do
    it "should generate have empty token by default" do
      ad_platform = FactoryGirl.build(:ad_platform)
      ad_platform.token.should be_nil
    end

    it "should generate token after create" do
      ad_platform = FactoryGirl.create(:ad_platform)
      ad_platform.token.should_not be_nil
    end
  end

  describe "instance methods" do

    let(:ad_platform) {FactoryGirl.create(:ad_platform_with_bars, user: FactoryGirl.create(:user))}

    it "should return bar" do
      ad_platform.bars.should include(ad_platform.get_next_bar)
    end

    it "should update recent bar id column" do
      ad_platform.recent_bar_id.should be_nil
      ad_platform.get_next_bar
      ad_platform.recent_bar_id.should_not be_nil
    end

    it "should return next bar evert time" do      
      bars = []
      ad_platform.bars.count.times do
        bars << ad_platform.get_next_bar
      end

      expect(bars).to match_array(ad_platform.bars)
    end

    it "should return first bar when cycle ends" do
      ad_platform.bars.count.times do |index|
        expect(ad_platform.get_next_bar).to eq(ad_platform.bars[index] == ad_platform.bars.last ? ad_platform.bars.first : ad_platform.bars[index + 1])
      end
    end

  end

end