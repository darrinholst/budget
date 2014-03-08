describe 'BudgetApp.Collections.Categories', ->
  beforeEach ->
    @categories = new BudgetApp.Collections.Categories()

  it 'calculates remaining amount with no categories', ->
    expect(@categories.remaining()).toEqual(0)

  it 'calculates remaining amount with some categories', ->
    @categories.add(category(100, 0), parse: true)
    @categories.add(category(250, 0), parse: true)
    expect(@categories.remaining()).toEqual(350)

  it 'calculates remaining amount with some negative categories', ->
    @categories.add(category(100, 0), parse: true)
    @categories.add(category(100, 150), parse: true)
    expect(@categories.remaining()).toEqual(100)

  category = (budgeted, spent) ->
    {buckets: [budgeted: budgeted, spent: spent]}
