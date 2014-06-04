require 'rails_helper'

RSpec.describe "ad_platforms/show", :type => :view do
  before(:each) do
    @ad_platform = assign(:ad_platform, AdPlatform.create!(
      :user_id => "",
      :name => "Name",
      :url => "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Url/)
  end
end
