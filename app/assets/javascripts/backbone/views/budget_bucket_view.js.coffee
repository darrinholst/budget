class BudgetApp.Views.BudgetBucketView extends BudgetApp.Views.BaseView
  className: "row-fluid bucket"

  events:
    "change input[name=name]": -> @model.name(@$("input[name=name]").val())
    "change input[name=budgeted]": -> @model.budgeted(@$("input[name=budgeted]").val())
    "change input[name=spent]": -> @model.spent(@$("input[name=spent]").val())
    "click [data-delete-bucket]": "deleteBucket"

  initialize: ->
    @model.bind("change", @sync)

  deleteBucket: ->
    if confirm("Are you sure?")
      @model.destroy()
      @remove()

  sync: =>
    # @model.save()
    @render()

