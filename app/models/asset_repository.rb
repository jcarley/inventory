class AssetRepository
  include Storage::Repository

  def initialize(db = Asset)
    super
  end

end

