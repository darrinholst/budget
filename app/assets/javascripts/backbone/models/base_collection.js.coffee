class BudgetApp.Collections.BaseCollection extends Backbone.Collection
  initialize: (models, options) ->
    super(models, options)
    @parent = options?.parent

