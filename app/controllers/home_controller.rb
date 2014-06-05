class HomeController < ApplicationController

  def index
    @ad_platforms = AdPlatform.all
  end
  
end
