require 'rails_helper'


RSpec.describe Assets::DeleteAssetCommand do

  it "deletes an asset" do
    asset = FactoryGirl.create(:asset)
    cmd = Assets::DeleteAssetCommand.new(:id => asset.id)
    expect { cmd.execute }.to change(Asset, :count).by(-1)
  end

end
