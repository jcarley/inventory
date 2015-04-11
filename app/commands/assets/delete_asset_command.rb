module Assets
  class DeleteAssetCommand < Command

    attribute :id, String

    def execute
      asset = Asset.delete_asset(self.id)
      repository = AssetRepository.new
      repository.delete(asset)
    end

  end
end
