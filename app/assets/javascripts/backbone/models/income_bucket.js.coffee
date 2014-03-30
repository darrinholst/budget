class BudgetApp.Models.IncomeBucket extends BudgetApp.Models.Bucket
  valid_attributes: [
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

  held: ->
    @models.reduce ((memo, bucket) -> memo + (if bucket.budgeted() < 0 then Math.abs(bucket.budgeted()) else 0)), 0

