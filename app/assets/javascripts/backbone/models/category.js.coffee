class BudgetApp.Models.Category extends BudgetApp.Models.BaseModel
  defaults:
    name: 'Name...'

  parse: (response) ->
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

class BudgetApp.Collections.Categories extends BudgetApp.Collections.BaseCollection
  model: BudgetApp.Models.Category

  budgeted: ->
    @models.reduce ((memo, category) -> memo + category.budgeted()), 0

  remaining: ->
    @models.reduce ((memo, category) -> memo + Math.abs(category.remaining())), 0

  toJSON: (includeBuckets) ->
    @map((model) -> model.toJSON(includeBuckets))

  clear: ->
    @each (model) -> model.buckets().clear()
