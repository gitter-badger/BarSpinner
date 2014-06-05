class ScriptsController < ApplicationController

  skip_before_filter :authenticate_user!

  respond_to :js

  def script
    @ad_platform = AdPlatform.find_by_token(params[:id])
    if @ad_platform 
      @bar = @ad_platform.bars[0]
      @bar.trigger_visit
    end
  end

  def preview
    if params[:bar_id]
      @bar = Bar.find(params[:bar_id])
    else
      @bar = Bar.new
    end
    render :script
  end

  def link
    @bar.trigger_click
    redirect_to @bar.link_url
  end

end
