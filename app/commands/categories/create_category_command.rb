module Categories
  class CreateCategoryCommand < Command

    attribute :id, String
    attribute :name, String
    attribute :locked, Boolean
    attribute :position, Integer

    validates :name, presence: true

    def execute
      parameters = self.to_params
      category = Category.create_category(parameters)
      repository = CategoryRepository.new
      repository.save(category)
      @id = category.id if category
    end

  end
end

