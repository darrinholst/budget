class BudgetApp.Views.BudgetExpensesView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget_expenses"]
  className: "expenses"

  events:
    "click [data-add-category]": "addNewCategory"

  addNewCategory: ->
    @collection.add({})
    newCategory = @collection.last()
    newCategory.save()
    @renderCategory(newCategory)

  renderCategory: (category) =>
    view = new BudgetApp.Views.BudgetExpenseCategoryView(model: category)
    @$(".row-fluid:last").before(view.render().el)

  render: ->
    $(@el).html(@template())
    @collection.each(@renderCategory)
    $(@el).sortable(axis: "y")
    @
