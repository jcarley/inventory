class AssetsController < ApplicationController

  def index
    repo = AssetRepository.new
    assets = repo.list
    render json: assets
  end

  def create
    cmd = Assets::CreateAssetCommand.new(asset_params)
    Domain.execute(cmd).on_success? do |result|
      render json: Asset.find(cmd.id)
    end.on_error? do |result|
      render status: :unprocessable_entity,
        json: {
          success: false,
          info: cmd.errors,
          data: {}
        }
    end
  end

  def update
    cmd = Assets::UpdateAssetCommand.new(:id => asset_id, :attrs => asset_params)
    Domain.execute(cmd).on_success? do |result|
      render status: :no_content, json: Asset.find(asset_id)
    end.on_error? do |result|
      render ResponseFormatter.format(self, result)
      # formatter = ResponseFormatter.new(self)
      # response_hash = formatter.format(result)
      # render response_hash
    end
  end

  def destroy

  end

  private

  def asset_params
    params.require(:asset)
  end

  def asset_id
    params.require(:id)
  end
      # if result.error.is_a?(NoBrainer::Error::DocumentNotFound)
        # render status: :not_found,
          # json: {
            # success: false,
            # info: result.error.message,
            # data: {}
          # }
      # else
        # render status: :unprocessable_entity,
          # json: {
            # success: false,
            # info: result.error.message,
            # data: {}
          # }
      # end
end
