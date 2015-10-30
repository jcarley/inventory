require 'rails_helper'

RSpec.describe Asset, type: :model do

  describe "public methods" do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:serial_number) }
    it { is_expected.to respond_to(:manufacturer) }
    it { is_expected.to respond_to(:purchase_date) }
    it { is_expected.to respond_to(:purchase_price) }
    it { is_expected.to respond_to(:purchased_from) }
    it { is_expected.to respond_to(:quantity) }
    it { is_expected.to respond_to(:value_new) }
    it { is_expected.to respond_to(:current_value) }
  end

  describe "#name" do

    it "requires a name" do
      asset = FactoryGirl.build(:asset, :name => "")
      expect(asset).to_not be_valid
    end
  end

  describe ".delete_asset" do

    it "is marked for deletion" do
      original_asset = FactoryGirl.create(:asset)
      expected_asset = Asset.delete_asset(original_asset.id)
      expect(expected_asset.is_deleted).to be(true)
    end

    it "is not deleted from the database" do
      original_asset = FactoryGirl.create(:asset)
      Asset.delete_asset(original_asset.id)
      expect(Asset.find(original_asset.id)).to_not be_nil
    end

    it "is deleted through repository" do
      original_asset = FactoryGirl.create(:asset)
      original_asset.delete_asset
      repo = AssetRepository.new
      repo.save(original_asset)
      expect{ Asset.find(original_asset.id) }.to raise_error(NoBrainer::Error::DocumentNotFound)
    end

  end


end
