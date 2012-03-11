class Budget < ActiveRecord::Base
  has_many :categories
  has_many :income_buckets
  has_many :expense_buckets, :through => :categories, :source => :buckets

  validates :starts_on, :presence => {message: "must be a valid date"}

  composed_of :actual_balance,
    :class_name => "Money",
    :mapping => [%w(actual_balance_cents cents)],
    :constructor => Proc.new { |cents, currency| Money.new(cents || 0, Money.default_currency) },
    :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }

  def starts_on=(date)
    write_attribute(:starts_on, Chronic.parse(date) || date)
  end

  def budgeted_income
    Money.new(income_buckets.sum(:budgeted_cents))
  end

  def budgeted_expenses
    Money.new(expense_buckets.sum(:budgeted_cents))
  end

  def spent
    Money.new(expense_buckets.sum(:spent_cents))
  end

  def left_to_spend
    budgeted_expenses - spent
  end

  def budgeted_buffer
    budgeted_income - budgeted_expenses
  end

  def actual_buffer
    actual_balance - left_to_spend
  end
end
