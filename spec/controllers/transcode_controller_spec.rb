require 'rails_helper'

RSpec.describe TranscodeController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    request.env["HTTP_USER_AGENT"] = "hello there ruby"
    request.env["Authorization"] = "ABC123:#{user.id}"
    request.env["Api-Key"] = "789XYZ"
  end

  describe "GET #invoke" do
    it "returns http success" do
      get :invoke
      expect(response).to have_http_status(:success)
    end

  end

end
