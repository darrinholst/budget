class BudgetApp.Views.BudgetIncomeView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget_income"]
  className: "income"

  events:
    "click [data-add-income]": "addNewIncomeBucket"

  initialize: ->
    @collection.on "change", @renderSummary
    @collection.on "remove", @renderSummary

  addNewIncomeBucket: ->
    @collection.add({})
    newBucket = @collection.last()
    newBucket.save()
    @renderBucket(newBucket, true)

  renderSummary: =>
    @$(".category").html(JST["backbone/templates/budget_income_summary"](
      budgeted: @formatMoney(@collection.budgeted())
    ))

  renderBucket: (bucket, focus) =>
    view = new BudgetApp.Views.BudgetIncomeBucketView(model: bucket)
    @$(".buckets").append(view.render().el)

    if(focus)
      focus = -> $(view.el).find("input[name=name]").focus()
      _.delay focus, 100

  renderBuckets: ->
    @collection.each (bucket) => @renderBucket(bucket)

  render: ->
    $(@el).html(@template())
    @renderSummary()
    @renderBuckets()
    @
