BudgetApp.Models.Budget = Backbone.RelationalModel.extend
  defaults: {
    actual_balance: 0
  }

  relations: [
    {
      type: Backbone.HasMany
      key: 'income_buckets'
      relatedModel: 'BudgetApp.Models.IncomeBucket'
      collectionType: 'BudgetApp.Collections.IncomeBuckets'
      includeInJSON: false
      reverseRelation:
        key: 'budget'
        includeInJSON: false
    },

    {
      type: Backbone.HasMany
      key: 'categories'
      relatedModel: 'BudgetApp.Models.Category'
      collectionType: 'BudgetApp.Collections.Categories'
      includeInJSON: false
      reverseRelation:
        key: 'budget'
        includeInJSON: false
    }
  ]

  startsOn: (newValue) -> if newValue then @set("starts_on", newValue) else @toDate(@get("starts_on"))
  actualBalance: (newValue) -> if newValue then @set("actual_balance", @parseMoney(newValue)) else @get("actual_balance")
  incomeBuckets: -> @get("income_buckets")
  expenseCategories: -> @get("categories")
  remaining: -> @expenseCategories().remaining()
  actualBuffer: -> @actualBalance() - @remaining()
  totalIncome: -> @incomeBuckets().budgeted()
  totalExpenses: -> @expenseCategories().budgeted()
  budgetedBuffer: -> @totalIncome() - @totalExpenses()
  parseMoney: (value) -> parseFloat(value, 10) * 100
  toDate: (value) -> Date.parse(value)

class BudgetApp.Collections.Budgets extends Backbone.Collection
  model: BudgetApp.Models.Budget
  url: -> '/budgets'
  comparator: (a, b) -> 
    return 1 if a.startsOn().getTime() < b.startsOn().getTime()
    return -1 if a.startsOn().getTime() > b.startsOn().getTime()
    return 0

