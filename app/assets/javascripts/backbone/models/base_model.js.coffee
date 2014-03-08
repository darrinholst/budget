class BudgetApp.Models.BaseModel extends Backbone.Model
  set: (key, value) ->
    super(key, value)

    model = @

    while model && model.collection && model.collection.parent
      model = model.collection.parent
      model.trigger('change')

