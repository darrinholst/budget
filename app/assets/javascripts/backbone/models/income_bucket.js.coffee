class BudgetApp.Models.IncomeBucket extends BudgetApp.Models.Bucket
  defaults:
    name: 'Name...'
    budgeted: 0

class BudgetApp.Collections.IncomeBuckets extends BudgetApp.Collections.Buckets
  model: BudgetApp.Models.IncomeBucket

