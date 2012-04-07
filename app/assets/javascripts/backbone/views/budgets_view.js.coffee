class BudgetApp.Views.BudgetsView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budgets"]

  initialize: () ->
    @collection.bind('reset', @addAll)

  addOne: (budget) =>
    view = new BudgetApp.Views.BudgetsRowView({model : budget})
    @$("tbody").append(view.render().el)

  addAll: () =>
    @collection.each(@addOne)

  render: =>
    $(@el).html(@template(budgets: @collection.toJSON()))
    @addAll()
    this
