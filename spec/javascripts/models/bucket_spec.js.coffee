describe "Bucket", ->
  category = null
  bucket = null

  beforeEach ->
    category = new BudgetApp.Models.Category()
    bucket = new BudgetApp.Models.Bucket(category: category)

  it "triggers a change on the category when changed", ->
    categoryChanged = false
    category.on('change', -> categoryChanged = true)
    bucket.budgeted('100')
    expect(categoryChanged).toBe(true)

