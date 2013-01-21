class BudgetRepository
  def all_for(user)
    user.budgets
        .order("starts_on desc")
        .includes([:income_buckets, {:categories => {:buckets => :itemizations}}])
        .all
  end
end
