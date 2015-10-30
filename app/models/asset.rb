class Asset
  include Entity

  field :name, type: String
  field :description, type: String
  field :serial_number, type: String
  field :manufacturer, type: String
  field :purchase_date, type: Date
  field :purchase_price, type: Float
  field :purchased_from, type: String
  field :quantity, type: Integer
  field :value_new, type: Float
  field :current_value, type: Float

  validates :name, :presence => true

  def self.create_asset(params)
    asset = Asset.new(params)
    asset.apply_event(:asset_created_event, params)
    asset
  end

  def self.delete_asset(id)
    asset = Asset.find(id)
    asset.delete_asset
    asset
  end

  def modify(params)
    asset.apply_event(:asset_modified_event, params)
  end

  def delete_asset
    apply_event(:asset_destroyed_event, :id => id)
  end

  private

  def on_asset_created(event)
    params = event.data
    assign_attributes(params)
  end

  def on_asset_destroyed(event)
    self.is_deleted = true
  end

  def on_asset_modified(event)
    params = event.data
    assign_attributes(params)
  end

end
