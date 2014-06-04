require 'rails_helper'

RSpec.describe "ad_platforms/index", :type => :view do
  before(:each) do
    assign(:ad_platforms, [
      AdPlatform.create!(
        :user_id => "",
        :name => "Name",
        :url => "Url"
      ),
      AdPlatform.create!(
        :user_id => "",
        :name => "Name",
        :url => "Url"
      )
    ])
  end

  it "renders a list of ad_platforms" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
