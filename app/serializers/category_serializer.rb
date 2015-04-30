class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :locked, :position
end
