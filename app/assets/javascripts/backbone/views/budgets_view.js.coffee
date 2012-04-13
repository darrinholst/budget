class BudgetApp.Views.BudgetsView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budgets"]
  className: "budgets"

  events: ->
    "click [data-add-budget]": => @collection.add({})

  initialize: ->
    @collection.on "reset", @addAll
    @collection.on "add", @newBudgetAdded
    @collection.on "reorder", =>
      @collection.sort()
      @render()

  newBudgetAdded: (budget) =>
    #TODO: need a activity indicator here

    budget.save({},
      success: (budget) =>
        @render()

      error: =>
        alert("Couldn't save new budget")
    )

  renderBudget: (budget) =>
    view = new BudgetApp.Views.BudgetsRowView({collection: @collection, model : budget})
    @$(".row-fluid:last").before(view.render().el)

  addAll: =>
    @collection.each(@renderBudget)

  render: =>
    $(@el).html(@template())
    @addAll()
    @

