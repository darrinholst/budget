class BudgetApp.Models.BaseModel extends Backbone.RelationalModel
  initialize: ->
    @on 'change', @_triggerParentChange
    @on 'remove', @_triggerParentChange

  _triggerParentChange: ->
    _.each(@getRelations(), (relation) -> relation.related && relation.related.trigger('change'))

  patch: (attributes) ->
    @save(attributes, {patch: true})

