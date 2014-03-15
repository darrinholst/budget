class BudgetApp.Models.BaseModel extends Backbone.Model
  initialize: ->
    super()
    @unset('id')
    @uid(guid()) unless @uid()

  uid: (newValue) ->
    if newValue?
      @set('uid', newValue)
    else
      @get('uid')

  set: (key, value) ->
    super(key, value)
    @_triggerParentChange(@collection)

  destroy: ->
    collection = @collection
    super()
    @_triggerParentChange(collection)

  _triggerParentChange: (collection)->
    parent = collection.parent

    while parent
      parent.trigger('change')
      parent = parent.collection?.parent
