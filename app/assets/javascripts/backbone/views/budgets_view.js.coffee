class BudgetApp.Views.BudgetsView extends Backbone.View
  template: JST["backbone/templates/budgets"]

  initialize: () ->
    @options.budgets.bind('reset', @addAll)

  addOne: (budget) =>
    view = new BudgetApp.Views.BudgetsRowView({model : budget})
    @$("tbody").append(view.render().el)

  addAll: () =>
    @options.budgets.each(@addOne)

  render: =>
    $(@el).html(@template(budgets: @options.budgets.toJSON()))
    @addAll()
    this
