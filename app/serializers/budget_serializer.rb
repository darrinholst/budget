class BudgetSerializer < ActiveModel::Serializer
  attributes :id, :starts_on, :actual_balance
  has_many :income_buckets
  has_many :categories
end