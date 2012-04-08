class BudgetApp.Models.Budget extends Backbone.Model
  paramRoot: 'budget'

  defaults: {
    actual_balance: 0
  }

  initialize: ->
    @income = new BudgetApp.Collections.Buckets()
    @income.reset @get("income_buckets")
    @categories = new BudgetApp.Collections.Categories()
    @categories.reset @get("categories")
    @set("starts_on", new Date(Date.parse(@get("starts_on"))))

  startsOn: -> @get("starts_on")
  actualBalance: (newValue) -> if newValue then @set("actual_balance", @parseMoney(newValue)) else @get("actual_balance")
  remaining: -> @categories.remaining()
  actualBuffer: -> @actualBalance() - @remaining()
  incomeBuckets: -> @income
  expenseCategories: -> @categories
  totalIncome: -> @income.budgeted()
  totalExpenses: -> @categories.budgeted()
  budgetedBuffer: -> @totalIncome() - @totalExpenses()
  parseMoney: (value) -> parseFloat(value, 10) * 100

class BudgetApp.Collections.Budgets extends Backbone.Collection
  model: BudgetApp.Models.Budget
  url: '/budgets'
