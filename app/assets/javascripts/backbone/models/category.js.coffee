class BudgetApp.Models.Category extends Backbone.Model
  initialize: (json) ->
    @buckets = new BudgetApp.Collections.Buckets()
    @buckets.reset json.buckets

  leftToSpend: ->
    @buckets.leftToSpend()

class BudgetApp.Collections.Categories extends Backbone.Collection
  model: BudgetApp.Models.Category

  leftToSpend: ->
    @models.reduce ((memo, category) -> memo + category.leftToSpend()), 0
