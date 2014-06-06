require 'rails_helper'

RSpec.describe ScriptsController, :type => :controller do

  let(:ad_platform) { FactoryGirl.create(:ad_platform_with_bars, user: FactoryGirl.create(:user)) }

  describe "GET 'script'" do

    context 'valid ad platform token' do
      it "returns http success" do
        xhr :get, 'script', id: ad_platform.token
        expect(response).to be_success
      end

      it "renders script template" do
        xhr :get, 'script', id: ad_platform.token
        expect(response).to render_template(:script)
      end

      it "assigns bar instance variable" do
        xhr :get, 'script', id: ad_platform.token
        expect(assigns(:bar)).to be_kind_of(Bar)
      end
    end

    context 'invalid ad platform token' do
      it "returns http success" do
        xhr :get, 'script', id: 1
        expect(response).to be_success
      end

      it "should not render template" do
        xhr :get, 'script', id: 1
        expect(response.body).to eq(' ')
      end

      it "assigns should be nil" do
        xhr :get, 'script', id: 1
        expect(assigns(:bar)).to be_nil
      end      
    end

  end

end
