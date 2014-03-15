class BudgetApp.Models.Budget extends Backbone.Model
  valid_attributes: [
    'id'
    'actual_balance'
    'starts_on'
    'ends_on'
    'income_buckets'
    'categories'
  ]

  short_attribute_names: {
    actual_balance: 'ab'
    starts_on: 'so'
    ends_on: 'eo'
    income_buckets: 'ib'
    categories: 'c'
  }

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

  uid: ->
    @id

  clone: ->
    cloned = super()
    cloned.unset('id')
    cloned

  parse: (response) ->
    @_unshortenAttributeNames(response)

    if @incomeBuckets()
      delete response.income_buckets
    else
      income_buckets = response.income_buckets || '[]'
      response.income_buckets = new BudgetApp.Collections.IncomeBuckets(JSON.parse(income_buckets), parent: this, parse: true)

    if @expenseCategories()
      delete response.categories
    else
      categories = response.categories || '[]'
      response.categories = new BudgetApp.Collections.Categories(JSON.parse(categories), parent: this, parse: true)

    response

  toJSON: ->
    json = super()
    json.income_buckets = JSON.stringify(json.income_buckets)
    json.categories = JSON.stringify(json.categories)

    @_shortenAttributeNames(@_cleanUpAttributes(json))

  _cleanUpAttributes: (json) ->
    (json[attribute] = null unless _.contains(@valid_attributes, attribute)) for attribute of json
    json

  _shortenAttributeNames: (json) ->
    (json[short] = json[long]; json[long] = null) for long, short of @short_attribute_names
    json

  _unshortenAttributeNames: (response) ->
    (response[long] = response[short] if response[short];delete(response[short])) for long, short of @short_attribute_names
    response

  startsOn: (newValue) ->
    if newValue?
      @set('starts_on', newValue)
    else
      @toDate(@get('starts_on'))

  endsOn: (newValue) ->
    if newValue?
      @set('ends_on', newValue)
    else
      @toDate(@get('ends_on'))

  actualBalance: (newValue) ->
    if newValue?
      @set('actual_balance', $.parseMoney(newValue))
    else
      @get('actual_balance')

  incomeBuckets: ->
    @get('income_buckets')

  expenseCategories: ->
    @get('categories')

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

  clear: ->
    @actualBalance(0)
    @expenseCategories().clear()
    @

class BudgetApp.Collections.Budgets extends BudgetApp.Collections.BaseCollection
  model: BudgetApp.Models.Budget
  url: -> '/budgets'
  dropboxDatastore: new Backbone.DropboxDatastore('budgets')

  comparator: (a, b) ->
    return 1 if a.startsOn().getTime() < b.startsOn().getTime()
    return -1 if a.startsOn().getTime() > b.startsOn().getTime()
    return 0

