class BudgetApp.Views.BudgetExpensesView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget_expenses"]
  className: "expenses"

  events:
    "click [data-add-category]": "addNewCategory"

  initialize: =>
    @collection.on "add", @newCategoryAdded

  addNewCategory: =>
    @collection.add({})

  newCategoryAdded: (category) =>
    category.save({},
      success: (category) =>
        @renderCategory(category, true)

      error: =>
        alert("Couldn't save new category")
    )

  renderCategory: (category, focus) =>
    view = new BudgetApp.Views.BudgetExpenseCategoryView(model: category)
    @$(".row-fluid:last").before(view.render().el)
    $(view.el).find("input[name=name]").focus() if focus

  render: ->
    $(@el).html(@template())
    @collection.each (category) => @renderCategory(category)
    $(@el).sortable(axis: "y")
    @
