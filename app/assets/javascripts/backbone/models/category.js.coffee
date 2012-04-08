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

  budgeted: -> @models.reduce ((memo, category) -> memo + category.budgeted()), 0
  remaining: -> @models.reduce ((memo, category) -> memo + category.remaining()), 0
