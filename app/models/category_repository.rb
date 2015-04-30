class CategoryRepository
  include Storage::Repository

  def initialize(db = Category)
    super
  end

end


