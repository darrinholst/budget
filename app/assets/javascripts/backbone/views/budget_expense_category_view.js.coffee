class BudgetApp.Views.BudgetExpenseCategoryView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget_expense_category"]
  className: "category-container"

  events:
    "change input[name=name]": "nameChanged"
    "click [data-add-expense]": "addNewExpenseBucket"
    "click [data-delete-category]": "deleteCategory"

  initialize: ->
    @model.bind "change", @renderSummary
    @model.bind "remove", @renderSummary
    @model.buckets().on "add", @newBucketAdded

  nameChanged: =>
    @model.name(@$("input[name=name]").val())
    @model.save()

  addNewExpenseBucket: ->
    @model.buckets().add({})

  newBucketAdded: (bucket) =>
    bucket.save({},
      success: (bucket) =>
        @renderBucket(bucket, true)

      error: =>
        alert("Couldn't save new bucket")
    )

  deleteCategory: =>
    if confirm("Are you sure?")
      @model.destroy()
      @remove()

  renderSummary: =>
    @$(".category").html(JST["backbone/templates/budget_expense_category_summary"](
      name: @model.name()
      budgeted: @formatMoney(@model.budgeted())
      spent: @formatMoney(@model.spent())
      remaining: @formatMoney(@model.remaining())
    )).inlineEditable()

  renderBucket: (bucket, focus) =>
    view = new BudgetApp.Views.BudgetExpenseBucketView(model: bucket)
    @$(".buckets").append(view.render().el)
    $(view.el).find("input[name=name]").focus() if focus

  renderBuckets: ->
    @model.buckets().each (bucket) => @renderBucket(bucket)
    @$(".buckets").sortable(axis: "y")

  render: ->
    $(@el).html(@template(name: @model.name())).inlineEditable()
    @renderSummary()
    @renderBuckets()
    @

