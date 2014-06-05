class ScriptsController < ApplicationController

  skip_before_filter :authenticate_user!

  respond_to :js

  def script
    @ad_platform = AdPlatform.find_by_token(params[:id])
    if @ad_platform 
      @bar = @ad_platform.bars[0]
    end
  end

end
