require 'rails_helper'
 
RSpec.describe Bar, :type => :model do
  
  
  describe 'mass assignment' do 
    [:link_text, :link_url, :message, :name, :setting_attributes].each do |e|
      it { should allow_mass_assignment_of(e) }
    end
  end

  describe 'validations' do
    [:link_text, :link_url, :message, :name, :ad_platform_id].each do |e|
      it { should validate_presence_of(e) }
    end
  end

  describe "associations" do
    it { should belong_to(:ad_platform) }
    it { should have_many(:clicks) }
    it { should have_many(:visits) }
    it { should have_one(:setting) }
  end

  describe "instance_methods" do

    let(:bar) { FactoryGirl.create(:bar) } 

    it "should increase clicks counter" do
      expect{ bar.trigger_click; bar.reload }.to change{ bar.clicks_count }.from(0).to(1)
    end

    it "should increase visits counter" do
      expect{ bar.trigger_visit; bar.reload }.to change{ bar.visits_count }.from(0).to(1)
    end
  end


end