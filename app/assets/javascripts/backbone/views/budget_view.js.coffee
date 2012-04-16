class BudgetApp.Views.BudgetView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget"]

  render : (event) ->
    $(@el).html(@template())
    @$("[data-income-container]").html(new BudgetApp.Views.BudgetIncomeView(model: @model, collection: @model.incomeBuckets()).render().el)
    @$("[data-expenses-container]").html(new BudgetApp.Views.BudgetExpensesView(model: @model, collection: @model.expenseCategories()).render().el)
    @$("[data-overview-container]").html(new BudgetApp.Views.BudgetOverviewView(model: @model).render().el)
    @
