class BudgetApp.Views.BudgetView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget"]

  fillDropDown: =>
    $(".nav.budget-list").show()
    $(".nav.budget-list .current-budget").html(@formatDate(@model.startsOn()))
    available = $(".nav.budget-list .available-budgets")
    available.html("")
    @model.collection.each (budget) =>
      available.append("<li><a href=\"#{budget.url()}\" data-push-state>#{@formatDate(budget.startsOn())}</a></li>") unless budget.id == @model.id


  render : (event) ->
    $(@el).html(@template())
    @$("[data-income-container]").html(new BudgetApp.Views.BudgetIncomeView(model: @model, collection: @model.incomeBuckets()).render().el)
    @$("[data-expenses-container]").html(new BudgetApp.Views.BudgetExpensesView(model: @model, collection: @model.expenseCategories()).render().el)
    @$("[data-overview-container]").html(new BudgetApp.Views.BudgetOverviewView(model: @model).render().el)
    @fillDropDown()
    @
