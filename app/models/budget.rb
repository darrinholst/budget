class Budget < ActiveRecord::Base
  has_many :categories
  has_many :income_buckets
  has_many :expense_buckets, :through => :categories, :source => :buckets
end
