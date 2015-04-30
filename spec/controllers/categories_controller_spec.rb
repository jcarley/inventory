require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do

  describe "POST create" do

    context "with valid attributes" do
      it "creates a category" do
        attributes = FactoryGirl.attributes_for(:category)
        expect { post :create, :category => attributes, :format => :json }.to change(Category, :count).by(1)
      end
    end

  end

end
