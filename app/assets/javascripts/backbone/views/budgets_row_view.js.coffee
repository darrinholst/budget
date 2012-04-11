class BudgetApp.Views.BudgetsRowView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budgets_row"]
  tagName: "tr"

  events: ->
    "click [data-edit-budget]": @edit

  edit: =>
    if @model.isNew()
      @model.save {},
        success: @editPage
        failure: -> alert("OOPS")
    else
      @editPage()

  editPage: =>
    @collection.add(@model)
    window.router.navigate("budgets/#{@model.id}", {trigger: true, replace: true})

  render: ->
    $(@el).html(@template(
      id: @model.id
      starts_on: @formatDate(@model.startsOn())
      actual_balance: @formatMoney(@model.actualBalance())
      remaining: @formatMoney(@model.remaining())
      actual_buffer: @formatMoney(@model.actualBuffer())
    ))

    return this
