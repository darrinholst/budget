class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :sort_order
  has_many :buckets
end
