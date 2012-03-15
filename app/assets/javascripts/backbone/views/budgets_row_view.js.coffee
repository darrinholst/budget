class BudgetApp.Views.BudgetsRowView extends Backbone.View
  template: JST["backbone/templates/budgets_row"]

  tagName: "tr"

  render: ->
    $(@el).html(@template(@model.toJSON()))
    this
