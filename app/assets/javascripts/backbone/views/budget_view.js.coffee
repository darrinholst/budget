class BudgetApp.Views.BudgetView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget"]

  initialize: (options) =>
    @readonly = options.readonly

  events:
    "click [data-collapse-all]": "collapseAll"
    "click [data-expand-all]": "expandAll"

  collapseAll: =>
    $(".buckets").slideUp()
    $(".collapse-category").removeClass("icon-angle-down").addClass("icon-angle-right")

  expandAll: =>
    $(".buckets").slideDown()
    $(".collapse-category").removeClass("icon-angle-right").addClass("icon-angle-down")

  fillDropDown: =>
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
    $(@el).html(@template(readonly: @readonly))
    @$("[data-income-container]").html(new BudgetApp.Views.IncomeView(model: @model, collection: @model.incomeBuckets()).render().el)
    @$("[data-expenses-container]").html(new BudgetApp.Views.ExpensesView(model: @model, collection: @model.expenseCategories()).render().el)
    @$("[data-overview-container]").html(new BudgetApp.Views.OverviewView(model: @model).render().el)
    @fillDropDown()
    @
