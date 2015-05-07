require 'rails_helper'

RSpec.describe AssetsController, type: :controller do

  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    request.env["HTTP_USER_AGENT"] = "hello there ruby"
    request.env["Authorization"] = "ABC123:#{user.id}"
    request.env["Api-Key"] = "789XYZ"
  end

  describe "GET #index" do

    let(:assets) do
      list = FactoryGirl.create_list(:asset, 10)
      serializer_class = ActiveModel::Serializer.serializer_for(list)
      serializer = serializer_class.new(list, {})
      serializer.as_json
    end

    it "gets a list of assets" do
      # grab the first five assets created, and format as json
      sliced_json = {assets: assets.slice(0..4) }.to_json

      # query for the first 5 assets through the api
      get :index, :offset => 0, :limit => 5, format: :json
      expect(response).to have_http_status(:ok)
      expect(normalize_json(response.body)).to be_json_eql(normalize_json(sliced_json))
    end

  end

  describe "POST #create" do

    context "with valid params" do
      it "creates an asset" do
        asset_params = FactoryGirl.attributes_for(:asset)
        expect { post :create, :asset => asset_params, format: :json }.to change(Asset, :count).by(1)
      end
    end

  end

  describe "PUT #update" do

    context "on success" do

      let(:asset) { FactoryGirl.create(:asset) }
      let(:asset_id) { asset.id }
      let(:asset_params) { { description: "New tool description" } }

      it "updates an asset" do
        put :update, :id => asset_id, :asset => asset_params, format: :json
        expect(Asset.find(asset_id).description).to eql(asset_params[:description])
      end

      it "returns the updated asset" do
        put :update, :id => asset_id, :asset => asset_params, format: :json
        actual_json = normalize_json(response.body)
        expected_json = normalize_json(Asset.find(asset_id).to_json)
        expect(actual_json).to be_json_eql(expected_json)
      end

      it "returns a status of 204" do
        put :update, :id => asset_id, :asset => asset_params, format: :json
        expect(response).to have_http_status(:ok)
      end

    end

    context "on failure" do
      let(:asset) { FactoryGirl.create(:asset) }
      let(:asset_id) { asset.id }
      let(:asset_params) { { description: "New tool description" } }

      it "does not update the asset" do
        allow_any_instance_of(Assets::UpdateAssetCommand).to receive(:execute).and_raise("error")
        put :update, :id => asset_id, :asset => asset_params, format: :json
        expect(Asset.find(asset_id).description).to_not eql(asset_params[:description])
      end

      it "returns the json error message" do
        allow_any_instance_of(Assets::UpdateAssetCommand).to receive(:execute).and_raise("error")
        put :update, :id => asset_id, :asset => asset_params, format: :json
        actual_json = normalize_json(response.body)
        expected_json = generate_normalized_json({success: false, info: 'RuntimeError: error', data: {}})
        expect(actual_json).to be_json_eql(expected_json)
      end

      it "returns a status of 422 unprocessable_entity" do
        allow_any_instance_of(Assets::UpdateAssetCommand).to receive(:execute).and_raise("error")
        put :update, :id => asset_id, :asset => asset_params, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns a status of 404 not_found when the asset is not found" do
        put :update, :id => "ABC123", :asset => asset_params, format: :json
        expect(response).to have_http_status(:not_found)
      end

    end

  end

  describe "DELETE #destroy" do

    context "on success" do

      let!(:asset) { FactoryGirl.create(:asset) }
      let(:asset_id) { asset.id }

      it "removes an asset from the database" do
        expect { put :destroy, :id => asset_id, format: :json }.to change(Asset, :count).by(-1)
      end

      it "returns a 204 :no_content status" do
        put :destroy, :id => asset_id, format: :json
        expect(response).to have_http_status(:no_content)
      end

    end
  end

end
