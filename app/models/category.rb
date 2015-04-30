class Category
  include Entity

  field :name, :type => String
  field :locked, :type => Boolean
  field :position, :type => Integer

  def self.create_category(params)
    category = Category.new(params)
    category.apply_event(:created_category, params)
    category
  end
end
