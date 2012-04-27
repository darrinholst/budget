class BudgetApp.Views.BudgetBucketView extends BudgetApp.Views.BaseView
  className: "row-fluid bucket"

  events:
    "change input[name=name]": "nameChanged"
    "change input[name=budgeted]": "budgetedChanged"
    "change input[name=spent]": "spentChanged"
    "click [data-delete-bucket]": "deleteBucket"

  initialize: =>
    @model.bind("change", @render)

  nameChanged: =>
    @model.name(@$("input[name=name]").val())
    @model.save()
    @checkForCleared()

  budgetedChanged: =>
    @model.budgeted(@$("input[name=budgeted]").val())
    @model.save()
    @checkForCleared()

  spentChanged: =>
    @model.spent(@$("input[name=spent]").val())
    @model.save()

  deleteBucket: =>
    if confirm("Are you sure?")
      @model.destroy()
      @remove()

  checkForCleared: =>
    if @model.remaining() == 0
      $(@el).addClass("cleared")
    else
      $(@el).removeClass("cleared")


