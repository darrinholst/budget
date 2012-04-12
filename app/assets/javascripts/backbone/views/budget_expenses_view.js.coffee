class BudgetApp.Views.BudgetExpensesView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget_expenses"]
  className: "expenses"

  events:
    "click [data-add-category]": "addNewCategory"

  addNewCategory: ->
    @collection.add({})
    newCategory = @collection.last()
    newCategory.save()
    @renderCategory(newCategory, true)

  renderCategory: (category, focus) =>
    view = new BudgetApp.Views.BudgetExpenseCategoryView(model: category)
    @$(".row-fluid:last").before(view.render().el)

    if(focus)
      focus = -> $(view.el).find("input[name=name]").focus()
      _.delay focus, 100

  render: ->
    $(@el).html(@template())
    @collection.each (category) => @renderCategory(category)
    $(@el).sortable(axis: "y")
    @
