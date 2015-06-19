class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :rating
end
