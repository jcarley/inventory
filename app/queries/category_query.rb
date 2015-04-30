class CategoryQuery

  def list(options = {})
    page_number = options.fetch(:page_number, 0)
    page_size = options.fetch(:page_size, 10)
    repo = CategoryRepository.new
    repo.list(page_number, page_size)
  end

end
