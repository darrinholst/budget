BudgetApp.Models.IncomeBucket = BudgetApp.Models.Bucket.extend
  defaults:
    name: "Name..."
    budgeted: 0

class BudgetApp.Collections.IncomeBuckets extends BudgetApp.Collections.Buckets
  model: BudgetApp.Models.IncomeBucket

  initialize: ->
    super()
    @localStorage = BudgetApp.localStorage

  url: ->
    "#{@.budget.url()}/incomes"

  clone: ->
    cloned = new BudgetApp.Collections.IncomeBuckets()
    cloned.add(bucket.clone()) for bucket in @models
    cloned

