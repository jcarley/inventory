require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    request.headers["HTTP_USER_AGENT"] = "hello there ruby"
    request.headers["Authorization"] = "ABC123:#{user.id}"
    request.headers["Api-Key"] = "789XYZ"
  end

  describe "POST create" do

    context "with valid attributes" do
      it "creates a category" do
        attributes = FactoryGirl.attributes_for(:category)
        expect { post :create, :category => attributes, :format => :json }.to change(Category, :count).by(1)
      end
    end

  end

end
