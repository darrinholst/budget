BudgetApp.Models.IncomeBucket = BudgetApp.Models.Bucket.extend
  defaults:
    name: "Name..."
    budgeted: 0

  initialize: ->
    @bind "change", => _.each(@getRelations(), (relation) -> relation.related && relation.related.trigger("change"))

class BudgetApp.Collections.IncomeBuckets extends BudgetApp.Collections.Buckets
  model: BudgetApp.Models.IncomeBucket

  url: -> "#{@.budget.url()}/incomes"

