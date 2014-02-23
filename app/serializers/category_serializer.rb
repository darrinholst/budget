class CategorySerializer < ApplicationSerializer
  attributes :id, :name, :sort_order
  has_many :buckets
end
