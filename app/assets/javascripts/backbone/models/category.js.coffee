class BudgetApp.Models.Category extends BudgetApp.Models.BaseModel
  valid_attributes: [
    'uid'
    'name'
    'buckets'
  ]

  short_attribute_names: {
    name: 'n'
    buckets: 'b'
  }

  defaults:
    name: 'Name...'

  parse: (response) ->
    super(response)
    response.buckets = new BudgetApp.Collections.Buckets(response.buckets, parent: this, parse: true)
    response

  name: (newValue) ->
    if newValue?
      @set('name', newValue)
    else
      @get('name')

  budgeted: ->
    @buckets().budgeted()

  spent: ->
    @buckets().spent()

  remaining: ->
    @buckets().remaining()

  buckets: ->
    @get('buckets')

  percentSpent: ->
    Math.round(((@spent() / @budgeted()) || 0) * 100)

class BudgetApp.Collections.Categories extends BudgetApp.Collections.BaseCollection
  model: BudgetApp.Models.Category

  budgeted: ->
    @models.reduce ((memo, category) -> memo + category.budgeted()), 0

  remaining: ->
    @models.reduce ((memo, category) -> memo + Math.abs(category.remaining())), 0

  clear: ->
    @each (model) -> model.buckets().clear()
