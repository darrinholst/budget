class BudgetApp.Models.Bucket extends BudgetApp.Models.BaseModel
  valid_attributes: [
    'name'
    'budgeted'
    'spent'
    'itemizations'
    'collapsed'
  ]

  short_attribute_names: {
    name: 'n'
    budgeted: 'b'
    spent: 's'
    itemizations: 'i'
  }

  defaults:
    name: 'Name...'
    budgeted: 0
    spent: 0

  parse: (response) ->
    super(response)
    itemizations = response.itemizations || []
    response.itemizations = new BudgetApp.Collections.Itemizations(itemizations, parent: this, parse: true)
    response

  name: (newValue) ->
    if newValue?
      @set('name', newValue)
    else
      @get('name')

  budgeted: (newValue) ->
    if newValue?
      @set('budgeted', $.parseMoney(newValue))
    else
      @get('budgeted')

  spent: (newValue) ->
    if newValue?
      @set('spent', $.parseMoney(newValue))
    else
      if @itemizations().any() then @itemizations().spent() else @get('spent')

  remaining: ->
    @budgeted() - @spent()

  itemizations: (newValues) ->
    if newValues?
      @set('itemizations', newValues)
    else
      @get('itemizations') || new BudgetApp.Collections.Itemizations([], parent: this)

class BudgetApp.Collections.Buckets extends BudgetApp.Collections.BaseCollection
  model: BudgetApp.Models.Bucket

  budgeted: ->
    @models.reduce ((memo, bucket) -> memo + bucket.budgeted()), 0

  spent: ->
    @models.reduce ((memo, bucket) -> memo + bucket.spent()), 0

  remaining: ->
    @models.reduce ((memo, bucket) -> memo + (if bucket.remaining() < 0 then 0 else bucket.remaining())), 0

  #TODO: remove when start using income specific categories
  held: ->
    @models.reduce ((memo, bucket) -> memo + (if bucket.budgeted() < 0 then Math.abs(bucket.budgeted()) else 0)), 0

  clear: ->
    @each (bucket) ->
      bucket.spent(0)
      bucket.itemizations().clear()

