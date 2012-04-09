class BudgetApp.Views.BudgetIncomeView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget_income"]
  className: "income"

  events:
    "click [data-add-income]": "addNewIncomeBucket"

  initialize: ->
    @collection.bind "change", @renderSummary

  addNewIncomeBucket: ->
    @collection.add({})
    newBucket = @collection.last()
    newBucket.save()
    @renderBucket(newBucket)

  renderSummary: =>
    @$(".category").html(JST["backbone/templates/budget_income_summary"](
      budgeted: @formatMoney(@collection.budgeted())
    ))

  renderBucket: (bucket) =>
    @$(".buckets").append(new BudgetApp.Views.BudgetIncomeBucketView(model: bucket).render().el)

  renderBuckets: ->
    @collection.each @renderBucket

  render: ->
    $(@el).html(@template())
    @renderSummary()
    @renderBuckets()
    @
