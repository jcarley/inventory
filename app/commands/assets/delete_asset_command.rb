module Assets
  class DeleteAssetCommand < Command

    attribute :id, String

    def execute
      repository = AssetRepository.new
      repository.delete_by(self.id)
    end

  end
end
