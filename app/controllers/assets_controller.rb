class AssetsController < ApplicationController

  def index
    # This should be a query object, and pulled from elasticsearch
    paging_params = query_string_params
    repo = AssetRepository.new
    assets = repo.list(paging_params["offset"], paging_params["limit"])
    render json: assets
  end

  def create
    cmd = Assets::CreateAssetCommand.new(asset_params)
    Domain.execute(cmd) do
      is_success? { |result| render json: Asset.find(cmd.id) }
      is_error? { |result| render Services::ResponseErrorFormatter.format(self, result.error) }
    end
  end

  def update
    cmd = Assets::UpdateAssetCommand.new(:id => asset_id, :attrs => asset_params)
    Domain.execute(cmd) do
      is_success? { |result| render status: :ok, json: Asset.find(asset_id) }
      is_error? { |result| render Services::ResponseErrorFormatter.format(self, result.error) }
    end
  end

  def destroy
    cmd = Assets::DeleteAssetCommand.new(:id => asset_id)
    Domain.execute(cmd) do
      is_success? { |result| render status: :no_content, json: {} }
      is_error? { |result| render Services::ResponseErrorFormatter.format(self, result.error) }
    end
  end

  private

  def query_string_params
    params.permit(:offset, :limit)
  end

  def asset_params
    params.require(:asset).permit(:name, :description, :serial_number, :manufacturer,
                                  :purchase_date, :purchase_price, :purchased_from, :quantity,
                                  :value_new, :current_value)
  end


  def asset_id
    params.require(:id)
  end

end
