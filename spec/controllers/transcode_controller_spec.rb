require 'rails_helper'

RSpec.describe TranscodeController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    request.headers["HTTP_USER_AGENT"] = "hello there ruby"
    request.headers["Authorization"] = "ABC123:#{user.id}"
    request.headers["Api-Key"] = "789XYZ"
  end

  describe "GET #invoke" do
    it "returns http success" do
      get :invoke
      expect(response).to have_http_status(:success)
    end

  end

end
