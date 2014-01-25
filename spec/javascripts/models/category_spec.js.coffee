describe "Category", ->
  describe "Instance", ->
    category = null
    budget = null

    beforeEach ->
      budget = new BudgetApp.Models.Budget()
      category = new BudgetApp.Models.Category(budget: budget)

    it "triggers a change on the budget when changed", ->
      budgetChanged = false
      budget.on('change', -> budgetChanged = true)
      category.name('name')
      expect(budgetChanged).toBe(true)

  describe "Collection", ->
    categories = null

    beforeEach ->
      categories = new BudgetApp.Collections.Categories()

    it "calculates remaining amount with no categories", ->
      expect(categories.remaining()).toEqual(0)

    it "calculates remaining amount with some categories", ->
      categories.add(category(100, 0))
      categories.add(category(250, 0))
      expect(categories.remaining()).toEqual(350)

    it "calculates remaining amount with some negative categories", ->
      categories.add(category(100, 0))
      categories.add(category(100, 150))
      expect(categories.remaining()).toEqual(100)

    category = (budgeted, spent) ->
      {buckets: [budgeted: budgeted, spent: spent]}
