class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :locked, :sequence
end
