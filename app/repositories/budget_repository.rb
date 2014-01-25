class BudgetRepository
  def all_for(user)
    user.budgets
        .order("starts_on desc")
        .includes([:income_buckets, {:categories => {:buckets => :itemizations}}])
        .limit(12)
        .all
  end

  def create(params)
    Budget.create!(params)
  end

  def find(id)
    Budget.find(id)
  end

  def update(budget, params)
    budget.update_attributes!(params)
  end

  def delete(budget)
    budget.destroy
  end
end
