class BudgetApp.Views.BudgetIncomeView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget_income"]
  className: "income"

  addBucket: (bucket) =>
    @$(".buckets").append(new BudgetApp.Views.BudgetIncomeRowView(model: bucket).render().el)

  render: ->
    $(@el).html(@template(budgeted: @formatMoney(@collection.budgeted())))
    @collection.each(@addBucket)
    @
