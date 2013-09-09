BudgetApp.Models.Itemization = BudgetApp.Models.BaseModel.extend
  defaults:
    name: "Name..."
    spent: 0

  initialize: ->
    @on "change", @triggerParentChange
    @on "remove", @triggerParentChange

  triggerParentChange: ->
    _.each(@getRelations(), (relation) -> relation.related && relation.related.trigger("change"))

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
    @localStorage = BudgetApp.localStorage

  url: ->
    "/buckets/#{@bucket.id}/itemizations"

  spent: ->
    @models.reduce ((memo, item) -> memo + item.spent()), 0

