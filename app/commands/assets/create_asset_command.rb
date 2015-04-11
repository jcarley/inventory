module Assets
  class CreateAssetCommand < Command

    attribute :id, String
    attribute :name, String
    attribute :description, String

    validates :name, presence: true

    def execute
      parameters = self.to_params
      asset = Asset.create_asset(self.to_params)
      repository = AssetRepository.new
      repository.save(asset)
      @id = asset.id if asset
    end

  end
end

