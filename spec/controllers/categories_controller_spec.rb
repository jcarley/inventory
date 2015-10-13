require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    request.env["HTTP_USER_AGENT"] = "hello there ruby"
    request.env["Authorization"] = "ABC123:#{user.id}"
    request.env["Api-Key"] = "789XYZ"
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
