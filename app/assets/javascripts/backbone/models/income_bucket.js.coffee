class BudgetApp.Models.IncomeBucket extends BudgetApp.Models.Bucket
  valid_attributes: [
    'uid'
    'name'
    'budgeted'
  ]

  short_attribute_names: {
    name: 'n'
    budgeted: 'b'
  }

  defaults:
    name: 'Name...'
    budgeted: 0

class BudgetApp.Collections.IncomeBuckets extends BudgetApp.Collections.Buckets
  model: BudgetApp.Models.IncomeBucket

