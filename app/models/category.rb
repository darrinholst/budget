class Category < ActiveRecord::Base
  has_many :buckets

  include BucketAggregator
end
