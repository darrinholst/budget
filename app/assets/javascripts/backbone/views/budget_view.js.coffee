class BudgetApp.Views.BudgetView extends Backbone.View
  template: JST["backbone/templates/budget"]

  render : ->
    $(@el).html(@template(@model.toJSON()))
    return this

