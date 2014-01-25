describe "IncomeBucket", ->
  bucket = null
  budget = null

  beforeEach ->
    budget = new BudgetApp.Models.Budget()
    bucket = new BudgetApp.Models.IncomeBucket(budget: budget)

  it "triggers a change on the budget when changed", ->
    budgetChanged = false
    budget.on('change', -> budgetChanged = true)
    bucket.budgeted('200')
    expect(budgetChanged).toBe(true)

