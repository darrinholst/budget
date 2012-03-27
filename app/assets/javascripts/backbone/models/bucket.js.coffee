class BudgetApp.Models.Bucket extends Backbone.Model
  defaults: {
    budgeted: 0
    spent: 0
  }

  leftToSpend: ->
    @get("budgeted") - @get("spent")

class BudgetApp.Collections.Buckets extends Backbone.Collection
  model: BudgetApp.Models.Bucket

  leftToSpend: ->
    @models.reduce ((memo, bucket) -> memo + bucket.leftToSpend()), 0

