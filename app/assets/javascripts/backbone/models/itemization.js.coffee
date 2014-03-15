class BudgetApp.Models.Itemization extends BudgetApp.Models.BaseModel
  valid_attributes: [
    'uid'
    'name'
    'spent'
  ]

  short_attribute_names: {
    name: 'n'
    spent: 's'
  }

  defaults:
    spent: 0

  initialize: ->
    super()
    @name("#{new Date().getMonth() + 1}/#{new Date().getDate()} - ") unless @name()

  name: (newValue) ->
    if newValue?
      @set('name', newValue)
    else
      @get('name')

  spent: (newValue) ->
    if newValue?
      @set('spent', $.parseMoney(newValue))
    else
      @get('spent')

class BudgetApp.Collections.Itemizations extends BudgetApp.Collections.BaseCollection
  model: BudgetApp.Models.Itemization

  spent: ->
    @models.reduce ((memo, item) -> memo + item.spent()), 0

