class AssetsController < ApplicationController

  def index
    repo = AssetRepository.new
    @assets = repo.list
    render json: @assets
  end

  def create
    parameters = asset_params
    @cmd = Assets::CreateAssetCommand.new(parameters)
    if Domain.execute(@cmd).is_successful?
      render json: Asset.find(@cmd.id)
    else
      render status: :unprocessable_entity,
        json: {
          success: false,
          info: @cmd.errors, data: {}
        }
    end
  end

  private

  def asset_params
    params.require(:asset)
  end
end
