module BucketAggregator
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
