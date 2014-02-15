class BudgetApp.Models.Itemization extends BudgetApp.Models.BaseModel
  defaults:
    spent: 0

  initialize: ->
    super()
    @name("#{new Date().getMonth() + 1}/#{new Date().getDate()} - ") unless @name()

  name: (newValue) ->
    if newValue?
      @set("name", newValue)
    else
      @get("name")

  spent: (newValue) ->
    if newValue?
      @set("spent", $.parseMoney(newValue))
    else
      @get("spent")

class BudgetApp.Collections.Itemizations extends Backbone.Collection
  model: BudgetApp.Models.Itemization

  initialize: ->
    super()
    @localStorage = BudgetApp.localStorage

  url: ->
    "/buckets/#{@bucket.id}/itemizations"

  spent: ->
    @models.reduce ((memo, item) -> memo + item.spent()), 0

