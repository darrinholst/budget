class BudgetApp.Views.ExpensesView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/expenses"]
  className: "expenses"

  events:
    "click [data-add-category]": "addNewCategory"
    "sortupdate .categories": "updateSortOrder"

  initialize: =>
    @collection.on "add", @newCategoryAdded

  updateSortOrder: =>
    categories = ({id: $(el).data("view").model.id, sort_order: i + 1} for el, i in @$(".category-wrapper"))
    @model.save(categories_attributes: categories)

  addNewCategory: =>
    @collection.add({})

  newCategoryAdded: (category) =>
    category.save({},
      success: (category) =>
        @renderCategory(category, true)
        @updateSortOrder()

      error: =>
        alert("Couldn't save new category")
    )

  renderCategory: (category, focus) =>
    view = new BudgetApp.Views.ExpenseCategoryView(model: category)
    @$(".categories").append(view.render().el)
    $(view.el).find("input[name=name]").focus() if focus
    $(view.el).data("view", view)

  render: ->
    $(@el).html(@template())
    @collection.each (category) => @renderCategory(category)
    @$(".categories").sortable(axis: "y")
    @
