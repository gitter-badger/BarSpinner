class ScriptsController < ApplicationController

  skip_before_filter :authenticate_user!

  respond_to :js

  def script
    @ad_platform = AdPlatform.find_by_token(params[:id])
    if @ad_platform 
      @bar = @ad_platform.get_next_bar
      @bar.trigger_visit
    else 
      render nothing: true
    end
  end

  def preview
    @bar = params[:bar_id] ? Bar.find(params[:bar_id]) : Bar.new
    render :script
  end

  def link
    @bar = Bar.find(params[:id])
    @bar.trigger_click
    redirect_to @bar.link_url
  end

end
