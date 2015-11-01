module Assets
  class UpdateAssetCommand < Command

    attribute :id, String
    attribute :attrs, Hash

    def execute
      repo = AssetRepository.new
      asset = repo.find(id)
      if asset
        repo.modify(asset, attrs)
        repo.save(asset)
      end
    end

  end
end

