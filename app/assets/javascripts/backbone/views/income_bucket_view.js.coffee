class BudgetApp.Views.IncomeBucketView extends BudgetApp.Views.BaseBucketView
  template: JST["backbone/templates/income_bucket"]
  className: 'clearfix bucket'

  render: =>
    $(@el).html(@template(
      name: @model.name(),
      budgeted: @formatMoney(@model.budgeted())
    )).inlineEditable()
    @
