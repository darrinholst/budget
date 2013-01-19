class BudgetApp.Views.ExpenseBucketView extends BudgetApp.Views.BaseBucketView
  template: JST["backbone/templates/expense_bucket"]

  render: =>
    $(@el).html(@template(
      name: @model.name()
      budgeted: @formatMoney(@model.budgeted())
      spent: @formatMoney(@model.spent())
      remaining: @formatMoney(@model.remaining())
    )).inlineEditable()

    @checkForCleared()

    @
