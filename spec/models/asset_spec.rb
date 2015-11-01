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

end
