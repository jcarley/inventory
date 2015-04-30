class Category
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :name, :type => String
  field :locked, :type => Boolean
  field :sequence, :type => Integer
end
