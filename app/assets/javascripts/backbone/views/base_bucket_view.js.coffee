#= require backbone/views/base_view

class BudgetApp.Views.BaseBucketView extends BudgetApp.Views.BaseView
  events: ->
    "change input[name=name]": "nameChanged"
    "change input[name=budgeted]": "budgetedChanged"
    "click [data-delete-bucket]": "deleteBucket"

  initialize: (options) ->
    super(options)
    @listenTo(@model, 'change', @colorize)
    @listenTo(@model, 'change:name', @renderName)
    @listenTo(@model, 'change:budgeted', @renderBudgeted)

  nameChanged: (event) =>
    @model.name(event.target.value)
    @budget.save()

  renderName: =>
    @$("input[name=name]").val(@model.name())

  budgetedChanged: (event) =>
    @model.budgeted(event.target.value)
    @budget.save()

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

