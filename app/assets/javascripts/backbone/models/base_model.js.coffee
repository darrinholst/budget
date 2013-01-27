class BudgetApp.Models.BaseModel extends Backbone.RelationalModel
  save: (key, value, options) ->
    #log "--Saving----------------------------------------------------------------"
    #log @
    #log arguments
    #log "------------------------------------------------------------------------"
    super(key, value, options)

  patch: (attributes) ->
    @save(attributes, {patch: true})

