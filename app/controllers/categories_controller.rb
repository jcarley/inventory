class CategoriesController < ApplicationController

  def index
    # categories = [
      # Category.new(id: 1, name: "Marking", locked: false, position: 0),
      # Category.new(id: 2, name: "Measuring", locked: false, position: 1),
      # Category.new(id: 3, name: "Saws", locked: false, position: 2),
      # Category.new(id: 4, name: "Screwdrivers", locked: false, position: 3),
      # Category.new(id: 5, name: "Chisels", locked: false, position: 4),
      # Category.new(id: 6, name: "Powertools", locked: false, position: 5)
    # ]
    query = CategoryQuery.new
    categories = query.list(:page_number => 0, :page_size => 10)
    render json: categories, meta: {total: 10}
  end

  def create
    cmd = Categories::CreateCategoryCommand.new(category_params)
    Domain.execute(cmd) do
      is_success? { |result| render json: Category.find(cmd.id) }
      is_error? { |result| render Lib::ResponseErrorFormatter.format(self, result.error) }
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :locked, :position)
  end

end
