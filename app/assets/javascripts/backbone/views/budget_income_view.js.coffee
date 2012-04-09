class BudgetApp.Views.BudgetIncomeView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget_income"]
  className: "income"

  initialize: ->
    @collection.bind "change", => @renderSummary()

  renderSummary: ->
    @$(".category").html(JST["backbone/templates/budget_income_summary"](
      budgeted: @formatMoney(@collection.budgeted())
    ))

  renderBuckets: ->
    @collection.each (bucket) =>
      @$(".buckets > div:last").before(new BudgetApp.Views.BudgetIncomeRowView(model: bucket).render().el)

  render: ->
    $(@el).html(@template())
    @renderSummary()
    @renderBuckets()
    @
