require 'rails_helper'

RSpec.describe TokensController, type: :controller do

  describe "GET access_token" do

    it "returns a users access token" do
      user = FactoryGirl.create(:user)
      get :access_token, id: user.id, format: :json
      puts response.body
    end

  end

  describe "POST token_exchange" do

  end

end
