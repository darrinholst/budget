class BudgetApp.Views.ExpenseCategoryBucketView extends BudgetApp.Views.BaseBucketView
  template: JST["backbone/templates/expense_category_bucket"]

  render: =>
    $(@el).html(@template(
      name: @model.name()
      budgeted: @formatMoney(@model.budgeted())
      spent: @formatMoney(@model.spent())
      remaining: @formatMoney(@model.remaining())
    )).inlineEditable()

    @checkForCleared()

    @
