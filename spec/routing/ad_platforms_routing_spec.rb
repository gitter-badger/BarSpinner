require "rails_helper"

RSpec.describe AdPlatformsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/ad_platforms").to route_to("ad_platforms#index")
    end

    it "routes to #new" do
      expect(:get => "/ad_platforms/new").to route_to("ad_platforms#new")
    end

    it "routes to #show" do
      expect(:get => "/ad_platforms/1").to route_to("ad_platforms#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/ad_platforms/1/edit").to route_to("ad_platforms#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/ad_platforms").to route_to("ad_platforms#create")
    end

    it "routes to #update" do
      expect(:put => "/ad_platforms/1").to route_to("ad_platforms#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/ad_platforms/1").to route_to("ad_platforms#destroy", :id => "1")
    end

  end
end
