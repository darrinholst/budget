class BudgetSerializer < ApplicationSerializer
  attributes :id, :starts_on, :ends_on, :actual_balance
  has_many :income_buckets
  has_many :categories
end
