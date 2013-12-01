class IncomeBucketSerializer < ActiveModel::Serializer
  attributes :id, :name, :budgeted, :sort_order
end
