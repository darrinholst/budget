BudgetApp.Models.IncomeBucket = BudgetApp.Models.Bucket.extend
  defaults:
    budgeted: 0

class BudgetApp.Collections.IncomeBuckets extends BudgetApp.Collections.Buckets
  model: BudgetApp.Models.IncomeBucket

  url: -> "#{@.budget.url()}/income"
