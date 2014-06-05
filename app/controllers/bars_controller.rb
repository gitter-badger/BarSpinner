class BarsController < InheritedResources::Base

  belongs_to :ad_platform

  def new
    @bar = Bar.new
    @bar.build_setting
    new!
  end

  def create
    create! { ad_platform_bars_url(@ad_platform) }
  end

  def update
    update! { ad_platform_bars_url(@ad_platform) }
  end

end
