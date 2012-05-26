describe "Category", ->
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
      categories.add(category(100, 150)) #overspending should add to remaining
      expect(categories.remaining()).toEqual(150)

    category = (budgeted, spent) ->
      {buckets: [budgeted: budgeted, spent: spent]}
