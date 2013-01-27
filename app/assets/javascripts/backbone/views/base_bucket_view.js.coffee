#= require backbone/views/base_view

class BudgetApp.Views.BaseBucketView extends BudgetApp.Views.BaseView
  events: ->
    "change input[name=name]": "nameChanged"
    "change input[name=budgeted]": "budgetedChanged"
    "click [data-delete-bucket]": "deleteBucket"

  initialize: =>
    @model.bind "change", @colorize
    @model.bind "change:name", @renderName
    @model.bind "change:budgeted", @renderBudgeted

  nameChanged: (event) =>
    @model.name(event.target.value)
    @model.patch(name: @model.name())

  renderName: =>
    @$("input[name=name]").val(@model.name())

  budgetedChanged: (event) =>
    @model.budgeted(event.target.value)
    @model.patch(budgeted: @model.budgeted())

  renderBudgeted: =>
    @$("input[name=budgeted]").val(@formatMoney(@model.budgeted()))
    @$("input[name=remaining]").val(@formatMoney(@model.remaining()))

  deleteBucket: =>
    if confirm("Are you sure?")
      @model.destroy()
      @remove()

  colorize: =>
    $(@el)[if @model.remaining() == 0 then "addClass" else "removeClass"]("cleared")
    $(@el)[if @model.remaining() < 0 then "addClass" else "removeClass"]("over")

