class BudgetApp.Models.BaseModel extends Backbone.Model
  set: (key, value) ->
    super(key, value)
    @_triggerParentChange(@collection)

  destroy: ->
    collection = @collection
    super()
    @_triggerParentChange(collection)

  parse: (response) ->
    @_unshortenAttributeNames(response)

  toJSON: (customCallback) ->
    json = super()
    customCallback(json) if _.isFunction(customCallback)
    @_shortenAttributeNames(@_cleanUpAttributes(json))

  _cleanUpAttributes: (json) ->
    nullifyOrDeleteAttribute = (attribute) =>
      unless _.contains(@valid_attributes, attribute)
        # sigh, if this model has an id then it's a top level dropbox record and we want to nullify
        # the attribute so it will be deleted in the record (deleting attributes leaves them in the
        # record). If it doesn't have a top level id then it's a relation of the top level record
        # which dropbox doesn't really support, but we fake it out by storing them as strings...in
        # this case we want to delete the attribute so it will be removed from the string.
        if @id then json[attribute] = null else delete(json[attribute])

    nullifyOrDeleteAttribute(attribute) for attribute of json if @valid_attributes

    json

  _shortenAttributeNames: (json) ->
    swapEm = (long, short) =>
      json[short] = json[long]
      # see comment above
      if @id then json[long] = null else delete(json[long])

    swapEm(long, short) for long, short of @short_attribute_names if @short_attribute_names

    json

  _unshortenAttributeNames: (response) ->
    swapEm = (long, short) =>
      response[long] = response[short] if response[short]
      delete(response[short])

    swapEm(long, short) for long, short of @short_attribute_names if @short_attribute_names

    response

  _triggerParentChange: (collection)->
    parent = collection?.parent

    while parent
      parent.trigger('change')
      parent = parent.collection?.parent
