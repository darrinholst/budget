class BudgetApp.Views.BudgetExpenseCategoryView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget_expense_category"]
  className: "category-container"

  addBucket: (bucket) =>
    @$(".buckets").append(new BudgetApp.Views.BudgetExpenseBucketView(model: bucket).render().el)

  render: ->
    $(@el).html(@template(
      name: @model.name()
      budgeted: @formatMoney(@model.budgeted())
      spent: @formatMoney(@model.spent())
      remaining: @formatMoney(@model.remaining())
    ))
    @model.buckets.each(@addBucket)
    @$(".buckets").sortable(axis: "y")
    @
