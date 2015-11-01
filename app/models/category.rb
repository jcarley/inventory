class Category
  include Entity

  field :name, :type => String
  field :locked, :type => Boolean
  field :position, :type => Integer

end
