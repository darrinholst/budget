class BudgetApp.Models.Category extends Backbone.Model
  initialize: (json) ->
    @buckets = new BudgetApp.Collections.Buckets()
    @buckets.reset json.buckets

class BudgetApp.Collections.Categories extends Backbone.Collection
  model: BudgetApp.Models.Category
