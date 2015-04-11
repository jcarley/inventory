class Asset
  include Entity

  field :name, type: String
  field :description, type: String
  field :serial_number, type: String
  field :manufacturer, type: String
  field :purchase_date, type: Time
  field :purchase_price, type: Float
  field :purchased_from, type: String
  field :quantity, type: Integer
  field :value_new, type: Float
  field :current_value, type: Float

  validates :name, :presence => true

  def self.create_asset(params)
    asset = Asset.new(params)
    asset.apply_event(:created_asset, params)
    asset
  end
end
