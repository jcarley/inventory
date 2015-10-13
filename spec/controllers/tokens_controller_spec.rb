require 'rails_helper'

RSpec.describe TokensController, type: :controller do

  describe "GET access_token" do

    context "with valid headers" do

      before(:each) do
        request.headers["HTTP_USER_AGENT"] = "hello there ruby"
        request.headers["Authorization"] = "ABC123:#{user.id}"
        request.headers["Api-Key"] = "789XYZ"
      end

      let(:user) { FactoryGirl.create(:user) }

      it "returns a users access token" do
        # puts ActionController::HttpAuthentication::Token.encode_credentials("ABC123", expiration: (DateTime.now + 1.day).rfc3339(9))

        get :access_token, format: :json
        expect(response.body).to have_json_path("token")
        expect(response.body).to have_json_path("expiration")
      end

    end

    context "with invalid headers" do

      let(:user) { FactoryGirl.create(:user) }

      it "returns a 401 :unauthorized when missing an sts token" do

        request.headers["Authorization"] = ""
        request.headers["Api-Key"] = "789XYZ"

        get :access_token, format: :json

        expect(response).to have_http_status(:unauthorized)
      end

      it "returns a 401 :unauthorized when missing an api key" do

        request.headers["Authorization"] = "ABC123:#{user.id}"
        request.headers["Api-Key"] = ""

        get :access_token, format: :json

        expect(response).to have_http_status(:unauthorized)
      end

      it "returns a 401 :unauthorized when the user is not enabled" do
        user = FactoryGirl.create(:user, :enabled => false)

        request.headers["Authorization"] = "ABC123:#{user.id}"
        request.headers["Api-Key"] = "789XYZ"

        get :access_token, format: :json

        expect(response).to have_http_status(:unauthorized)

      end

    end

  end

  describe "POST token_exchange" do

  end

end
