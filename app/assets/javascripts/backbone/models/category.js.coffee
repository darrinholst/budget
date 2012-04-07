class BudgetApp.Models.Category extends Backbone.Model
  initialize: (json) ->
    @buckets = new BudgetApp.Collections.Buckets()
    @buckets.reset json.buckets

  name: -> @get("name")
  budgeted: -> @buckets.budgeted()
  spent: -> @buckets.spent()
  remaining: -> @buckets.remaining()

class BudgetApp.Collections.Categories extends Backbone.Collection
  model: BudgetApp.Models.Category

  remaining: -> @models.reduce ((memo, category) -> memo + category.remaining()), 0
