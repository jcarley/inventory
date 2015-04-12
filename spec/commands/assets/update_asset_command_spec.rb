require 'rails_helper'

RSpec.describe Assets::UpdateAssetCommand do

  describe "#execute" do

    it "updates an asset" do
      asset = FactoryGirl.create(:asset)
      cmd = Assets::UpdateAssetCommand.new(:id => asset.id, :attrs => {description: "New Description"})
      cmd.execute
      asset.reload
      expect(asset.description).to eql("New Description")
    end

  end


end

