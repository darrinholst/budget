class BudgetApp.Models.Category extends Backbone.Model
  defaults:
    name: 'Name...'

  parse: (response) ->
    buckets = response.buckets || []
    response.buckets = new BudgetApp.Collections.Buckets(buckets, parse: true, budget: @collection.budget)
    response

  name: (newValue) ->
    if newValue?
      @set('name', newValue)
    else
      @get('name')

  buckets: ->
    @get('buckets')

  budgeted: ->
    @buckets().budgeted()

  spent: ->
    @buckets().spent()

  remaining: ->
    @buckets().remaining()

  save: (attributes, options) ->
    @collection.budget.save(attributes, options)

  parse: (response) ->
    response.buckets = new BudgetApp.Collections.Buckets(response.buckets, parse: true, budget: @collection.budget)
    response

  #clone: ->
    #cloned = Backbone.RelationalModel.prototype.clone.call(this)
    #cloned.set('buckets', @buckets().clone())
    #cloned

class BudgetApp.Collections.Categories extends Backbone.Collection
  model: BudgetApp.Models.Category

  initialize: (models, options) ->
    @budget = options.budget

  budgeted: ->
    @models.reduce ((memo, category) -> memo + category.budgeted()), 0

  remaining: ->
    @models.reduce ((memo, category) -> memo + Math.abs(category.remaining())), 0

  toJSON: (includeBuckets) ->
    @map((model) -> model.toJSON(includeBuckets))

  clear: ->
    @each (model) -> model.buckets().clear()

  clone: ->
    cloned = new BudgetApp.Collections.Categories()
    cloned.add(category.clone()) for category in @models
    cloned

