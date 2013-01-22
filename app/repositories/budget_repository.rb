class BudgetRepository
  def all_for(user)
    user.budgets
        .order("starts_on desc")
        .includes([:income_buckets, {:categories => {:buckets => :itemizations}}])
        .all
  end

  def create(user, params)
    user.budgets.create!(params)
  end

  def update(user, id, params)
    budget = user.budgets.find(id)
    budget.update_attributes!(params)
    budget
  end

  def delete(user, id)
    budget = user.budgets.find(id)
    budget.destroy
    budget
  end
end
