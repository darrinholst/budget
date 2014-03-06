class BudgetApp.Views.BudgetView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget"]

  events:
    "click [data-collapse-all]": "collapseAll"
    "click [data-expand-all]": "expandAll"
    "click [data-delete-budget]": "deleteBudget"

  collapseAll: ->
    $(".buckets").slideUp()
    $(".collapse-category").removeClass("fa-angle-down").addClass("fa-angle-right")

  expandAll: ->
    $(".buckets").slideDown()
    $(".collapse-category").removeClass("fa-angle-right").addClass("fa-angle-down")

  deleteBudget: ->
    if confirm("Are you sure?")
      @model.destroy()
      @remove()
      window.router.navigate('/budgets', true)

  fillDropDown: ->
    $(".nav.budget-list").show()
    $(".nav.budget-list .current-budget").html(@formatDate(@model.startsOn()))
    available = $(".nav.budget-list .available-budgets")
    available.html("")

    @model.collection.each (budget) =>
      if budget.id == @model.id
        available.append("<li class=\"current\">#{@formatDate(budget.startsOn())}</li>")
      else
        available.append("<li><a href=\"#{budget.url()}\" data-push-state>#{@formatDate(budget.startsOn())}</a></li>")

  render : (event) ->
    $(@el).html(@template())
    @$("[data-income-container]").html(@newView(BudgetApp.Views.IncomeView, collection: @model.incomeBuckets(), budget: @model).render().el)
    @$("[data-expenses-container]").html(@newView(BudgetApp.Views.ExpensesView, collection: @model.expenseCategories(), budget: @model).render().el)
    @$("[data-overview-container]").html(@newView(BudgetApp.Views.OverviewView, model: @model).render().el)
    @fillDropDown()
    @

