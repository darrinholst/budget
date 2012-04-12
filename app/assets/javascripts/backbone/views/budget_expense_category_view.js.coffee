class BudgetApp.Views.BudgetExpenseCategoryView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget_expense_category"]
  className: "category-container"

  events:
    "change input[name=name]": -> @model.name(@$("input[name=name]").val())
    "click [data-add-expense]": "addNewExpenseBucket"

  initialize: ->
    @model.bind "change:name", => @model.save()
    @model.bind "change", => @renderSummary()

  addNewExpenseBucket: ->
    @model.buckets().add({})
    newBucket = @model.buckets().last()
    newBucket.save()
    @renderBucket(newBucket, true)

  renderSummary: ->
    @$(".category").html(JST["backbone/templates/budget_expense_category_summary"](
      name: @model.name()
      budgeted: @formatMoney(@model.budgeted())
      spent: @formatMoney(@model.spent())
      remaining: @formatMoney(@model.remaining())
    )).inlineEditable()

  renderBucket: (bucket, focus) =>
    view = new BudgetApp.Views.BudgetExpenseBucketView(model: bucket)
    @$(".buckets").append(view.render().el)

    if(focus)
      focus = -> $(view.el).find("input[name=name]").focus()
      _.delay focus, 100

  renderBuckets: ->
    @model.buckets().each (bucket) => @renderBucket(bucket)
    @$(".buckets").sortable(axis: "y")

  render: ->
    $(@el).html(@template())
    @renderSummary()
    @renderBuckets()
    @
