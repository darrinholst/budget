class BudgetApp.Models.Budget extends BudgetApp.Models.BaseModel
  valid_attributes: [
    'id'
    'actual_balance'
    'starts_on'
    'ends_on'
    'income_categories'
    'categories'
  ]

  short_attribute_names: {
    actual_balance: 'ab'
    starts_on: 'so'
    ends_on: 'eo'
    income_buckets: 'ib'
    income_categories: 'ic'
    categories: 'c'
  }

  defaults: {
    actual_balance: 0

    income_categories: [
      {name: 'Income', buckets: [
        {name: "Salary"}
      ]}
    ],

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
    delete(cloned.id)
    cloned

  parse: (response) ->
    super(response)

    if response.income_buckets
      response.income_categories ||= JSON.stringify([{name: 'Income', buckets: JSON.parse(response.income_buckets)}])

    if @incomeCategories()
      delete response.income_categories
    else
      income_categories = response.income_categories || '[]'
      response.income_categories = new BudgetApp.Collections.Categories(JSON.parse(income_categories), parent: this, parse: true)

    if @expenseCategories()
      delete response.categories
    else
      categories = response.categories || '[]'
      response.categories = new BudgetApp.Collections.Categories(JSON.parse(categories), parent: this, parse: true)

    response

  toJSON: ->
    super((json) ->
      json.income_categories = JSON.stringify(json.income_categories)
      json.categories = JSON.stringify(json.categories)
    )

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
    @incomeCategories().at(0).buckets()

  incomeCategories: ->
    @get('income_categories')

  expenseCategories: ->
    @get('categories')

  remaining: ->
    @expenseCategories().remaining()

  actualBuffer: ->
    @actualBalance() - @remaining() - @incomeCategories().held()

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

  inFuture: ->
    days = moment(@startsOn()).startOf('day').diff(moment(Clock.now()).startOf('day'), 'days')
    days > 0

  percentComplete: ->
    now = Clock.now()
    startsOn = moment(@startsOn()).startOf('day')
    endsOn = moment(@endsOn()).endOf('day')

    if now <= endsOn and now >= startsOn
      totalDays = moment(endsOn).diff(moment(startsOn), 'days')
      completedDays = moment(Clock.now()).diff(moment(startsOn), 'days')
      Math.round((completedDays / (totalDays + 1)) * 100)

class BudgetApp.Collections.Budgets extends BudgetApp.Collections.BaseCollection
  model: BudgetApp.Models.Budget
  url: -> '/budgets'
  dropboxDatastore: new Backbone.DropboxDatastore('budgets')

  comparator: (a, b) ->
    return 1 if a.startsOn().getTime() < b.startsOn().getTime()
    return -1 if a.startsOn().getTime() > b.startsOn().getTime()
    return 0

