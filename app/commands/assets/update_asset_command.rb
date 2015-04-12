module Assets
  class UpdateAssetCommand < Command

    attribute :id, String
    attribute :attrs, Hash

    def execute
      repo = AssetRepository.new
      asset = repo.find(id)
      if asset
        # TODO: assign_attributes needs to be redirected through the model so that an update
        # event can be captured
        asset.assign_attributes(attrs)
        repo.save(asset)
      end
    end

  end
end

