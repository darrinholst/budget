BudgetApp.Views.Budgets ||= {}

class BudgetApp.Views.Budgets.IndexView extends Backbone.View
  template: JST["backbone/templates/budgets/index"]

  initialize: () ->
    @options.budgets.bind('reset', @addAll)

  addAll: () =>
    @options.budgets.each(@addOne)

  addOne: (budget) =>
    view = new BudgetApp.Views.Budgets.BudgetView({model : budget})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(budgets: @options.budgets.toJSON() ))
    @addAll()

    return this
