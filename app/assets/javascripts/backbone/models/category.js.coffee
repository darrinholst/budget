class BudgetApp.Models.Category extends Backbone.Model
  defaults:
    name: 'Name...'

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

  #toJSON: (includeBuckets) ->
    #json = Backbone.RelationalModel.prototype.toJSON.call(this)
    #json.buckets_attributes = @buckets().toJSON() if includeBuckets
    #json

  #clone: ->
    #cloned = Backbone.RelationalModel.prototype.clone.call(this)
    #cloned.set('buckets', @buckets().clone())
    #cloned

class BudgetApp.Collections.Categories extends Backbone.Collection
  model: BudgetApp.Models.Category

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

