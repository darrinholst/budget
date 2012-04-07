class BudgetApp.Models.Bucket extends Backbone.Model
  defaults: {
    budgeted: 0
    spent: 0
  }

  name: -> @get("name")
  budgeted: -> @get("budgeted")
  spent: -> @get("spent")
  remaining: -> @budgeted() - @spent()

class BudgetApp.Collections.Buckets extends Backbone.Collection
  model: BudgetApp.Models.Bucket

  budgeted: -> @models.reduce ((memo, bucket) -> memo + bucket.budgeted()), 0
  spent: -> @models.reduce ((memo, bucket) -> memo + bucket.spent()), 0
  remaining: -> @models.reduce ((memo, bucket) -> memo + bucket.remaining()), 0

