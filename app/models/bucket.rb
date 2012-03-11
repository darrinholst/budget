class Bucket < ActiveRecord::Base
  composed_of :budgeted,
    :class_name => "Money",
    :mapping => [%w(budgeted_cents cents)],
    :constructor => Proc.new { |cents, currency| Money.new(cents || 0, Money.default_currency) },
    :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }

  composed_of :spent,
    :class_name => "Money",
    :mapping => [%w(spent_cents cents)],
    :constructor => Proc.new { |cents, currency| Money.new(cents || 0, Money.default_currency) },
    :converter => Proc.new { |value| value.respond_to?(:to_money) ? value.to_money : raise(ArgumentError, "Can't convert #{value.class} to Money") }

  def remaining
    budgeted - spent
  end
end
