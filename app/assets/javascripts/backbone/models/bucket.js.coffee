class BudgetApp.Models.Bucket extends Backbone.Model
  defaults: {
    budgeted: 0
    spent: 0
  }

  name: (newValue) -> if newValue then @set("name", newValue) else @get("name")
  budgeted: (newValue) -> if newValue then @set("budgeted", @parseMoney(newValue)) else @get("budgeted")
  spent: (newValue) -> if newValue then @set("spent", @parseMoney(newValue)) else @get("spent")
  remaining: -> @budgeted() - @spent()
  parseMoney: (value) -> parseFloat(value, 10) * 100

class BudgetApp.Collections.Buckets extends Backbone.Collection
  model: BudgetApp.Models.Bucket

  budgeted: -> @models.reduce ((memo, bucket) -> memo + bucket.budgeted()), 0
  spent: -> @models.reduce ((memo, bucket) -> memo + bucket.spent()), 0
  remaining: -> @models.reduce ((memo, bucket) -> memo + bucket.remaining()), 0

