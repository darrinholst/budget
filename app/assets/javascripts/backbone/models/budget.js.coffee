BudgetApp.Models.Budget = BudgetApp.Models.BaseModel.extend
  defaults: {
    actual_balance: 0

    income_buckets: [
      {name: "Salary"}
    ]

    categories: [
      {name: "Housing", buckets: [
        {name: "Mortgage"}
        {name: "Taxes"}
      ]},
      {name: "Bills", buckets: [
        {name: "Electricity"}
        {name: "Water"}
        {name: "Gas"}
        {name: "Phone"}
        {name: "Trash"}
        {name: "Cable"}
      ]},
      {name: "Food", buckets: [
        {name: "Groceries"}
        {name: "Dining Out"}
      ]},
      {name: "Transportation", buckets: [
        {name: "Car Insurance"}
        {name: "Gas"}
      ]},
      {name: "Personal", buckets: [
        {name: "Health Insurance"}
        {name: "Life Insurance"}
        {name: "Child Care"}
      ]},
      {name: "Entertainment", buckets: [
        {name: "Blow Money"}
      ]},
      {name: "Savings", buckets: [
        {name: "Emergency Fund"}
      ]}
    ]
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

  startsOn: (newValue) ->
    if newValue?
      @set("starts_on", newValue)
    else
      @toDate(@get("starts_on"))

  endsOn: (newValue) ->
    if newValue?
      @set("ends_on", newValue)
    else
      @toDate(@get("ends_on"))

  actualBalance: (newValue) ->
    if newValue?
      @set("actual_balance", $.parseMoney(newValue))
    else
      @get("actual_balance")

  incomeBuckets: ->
    @get("income_buckets")

  expenseCategories: ->
    @get("categories")

  remaining: ->
    @expenseCategories().remaining()

  actualBuffer: ->
    @actualBalance() - @remaining()

  totalIncome: ->
    @incomeBuckets().budgeted()

  totalExpenses: ->
    @expenseCategories().budgeted()

  budgetedBuffer: ->
    @totalIncome() - @totalExpenses()

  toDate: (value) ->
    Date.parse(value)

  clone: ->
    cloned = Backbone.RelationalModel.prototype.clone.call(this)
    cloned.set("income_buckets", @incomeBuckets().clone())
    cloned.set("categories", @expenseCategories().clone())
    cloned

  clear: ->
    @actualBalance(0)
    @expenseCategories().clear()
    @

  toJSON: ->
    json = Backbone.RelationalModel.prototype.toJSON.call(this)

    if @isNew()
      json.income_buckets_attributes = @incomeBuckets().toJSON()
      json.categories_attributes = @expenseCategories().toJSON(true)

    json

class BudgetApp.Collections.Budgets extends Backbone.Collection
  model: BudgetApp.Models.Budget
  url: -> '/budgets'
  comparator: (a, b) ->
    return 1 if a.startsOn().getTime() < b.startsOn().getTime()
    return -1 if a.startsOn().getTime() > b.startsOn().getTime()
    return 0

