require 'rails_helper'

RSpec.describe HomeController, :type => :controller do

  describe "GET 'index'" do
    
    login_user

    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end
  end

end
