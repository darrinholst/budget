class BudgetApp.Views.BudgetIncomeBucketView extends BudgetApp.Views.BudgetBucketView
  template: JST["backbone/templates/budget_income_bucket"]

  render: ->
    $(@el).html(@template(
      name: @model.name(),
      budgeted: @formatMoney(@model.budgeted())
    )).inlineEditable()
    @
