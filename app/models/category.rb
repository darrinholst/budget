class Category < ActiveRecord::Base
  has_many :buckets

  def budgeted
    Money.new(buckets.sum(:budgeted_cents))
  end

  def spent
    Money.new(buckets.sum(:spent_cents))
  end

  def remaining
    budgeted - spent
  end
end
