require 'rails_helper'

RSpec.describe "ad_platforms/new", :type => :view do
  before(:each) do
    assign(:ad_platform, AdPlatform.new(
      :user_id => "",
      :name => "MyString",
      :url => "MyString"
    ))
  end

  it "renders new ad_platform form" do
    render

    assert_select "form[action=?][method=?]", ad_platforms_path, "post" do

      assert_select "input#ad_platform_user_id[name=?]", "ad_platform[user_id]"

      assert_select "input#ad_platform_name[name=?]", "ad_platform[name]"

      assert_select "input#ad_platform_url[name=?]", "ad_platform[url]"
    end
  end
end
