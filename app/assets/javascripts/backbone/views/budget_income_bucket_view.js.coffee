class BudgetApp.Views.BudgetIncomeBucketView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget_income_bucket"]
  className: "row-fluid bucket"

  events:
    "change input[name=name]": -> @model.name(@$("input[name=name]").val())
    "change input[name=budgeted]": -> @model.budgeted(@$("input[name=budgeted]").val())

  initialize: ->
    @model.bind("change", @sync)

  sync: =>
    @model.save()
    @render()

  render: ->
    $(@el).html(@template(
      name: @model.name(),
      budgeted: @formatMoney(@model.budgeted())
    )).inlineEditable()
    @
