class ProductSerializer < ActiveModel::Serializer
  attributes :code, :name, :price
end
