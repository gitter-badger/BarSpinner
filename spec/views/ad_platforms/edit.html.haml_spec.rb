require 'rails_helper'

RSpec.describe "ad_platforms/edit", :type => :view do
  before(:each) do
    @ad_platform = assign(:ad_platform, AdPlatform.create!(
      :user_id => "",
      :name => "MyString",
      :url => "MyString"
    ))
  end

  it "renders the edit ad_platform form" do
    render

    assert_select "form[action=?][method=?]", ad_platform_path(@ad_platform), "post" do

      assert_select "input#ad_platform_user_id[name=?]", "ad_platform[user_id]"

      assert_select "input#ad_platform_name[name=?]", "ad_platform[name]"

      assert_select "input#ad_platform_url[name=?]", "ad_platform[url]"
    end
  end
end
