require 'rails_helper'

RSpec.describe ScriptsController, :type => :controller do

  describe "GET 'script'" do
    it "returns http success" do
      get 'script'
      expect(response).to be_success
    end
  end

end
