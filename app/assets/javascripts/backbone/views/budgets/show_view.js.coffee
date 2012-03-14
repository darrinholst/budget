BudgetApp.Views.Budgets ||= {}

class BudgetApp.Views.Budgets.ShowView extends Backbone.View
  template: JST["backbone/templates/budgets/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
