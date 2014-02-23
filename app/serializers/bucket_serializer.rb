class BucketSerializer < ApplicationSerializer
  attributes :id, :name, :budgeted, :spent, :sort_order
  has_many :itemizations
end
