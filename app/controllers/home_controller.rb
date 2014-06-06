class HomeController < ApplicationController

  def index
    @ad_platforms = current_user.ad_platforms
  end
  
end
