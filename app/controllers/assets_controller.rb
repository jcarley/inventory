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
      render Lib::ResponseErrorFormatter.format(self, result.error)
    end
  end

  def update
    cmd = Assets::UpdateAssetCommand.new(:id => asset_id, :attrs => asset_params)
    Domain.execute(cmd).on_success? do |result|
      render status: :ok, json: Asset.find(asset_id)
    end.on_error? do |result|
      render Lib::ResponseErrorFormatter.format(self, result.error)
    end
  end

  def destroy
    cmd = Assets::DeleteAssetCommand.new(:id => asset_id)
    Domain.execute(cmd) do
      is_success? { |result| render status: :no_content, json: {} }
      is_error? { |result| render Lib::ResponseErrorFormatter.format(self, result.error) }
    end
  end

  private

  def asset_params
    params.require(:asset)
  end

  def asset_id
    params.require(:id)
  end

end
