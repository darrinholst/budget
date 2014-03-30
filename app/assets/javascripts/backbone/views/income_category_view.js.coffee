class BudgetApp.Views.IncomeCategoryView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/income"]
  className: "income-wrapper"

  events:
    "click [data-add-income]": "addNewIncomeBucket"
    "sortupdate .buckets": "updateSortOrder"
    "click [data-collapse]": "toggleCollapseCategory"

  initialize: (options) ->
    super(options)
    @listenTo(@model, 'change', @renderSummary)
    @listenTo(@model, 'remove', @renderSummary)
    @listenTo(@model.buckets(), 'add', @newBucketAdded)
    @listenTo(@model.buckets(), "destroy", @bucketRemoved)

  updateSortOrder: ->
    ids = ($(el).data('view').model.cid for el in @$('.bucket'))
    @model.buckets().models = @model.buckets().sortBy((bucket) -> ids.indexOf(bucket.cid))
    @budget.save()

  addNewIncomeBucket: ->
    @toggleCollapseCategory() if @categoryIsCollapsed()
    @model.buckets().add({})

  newBucketAdded: (bucket) ->
    @budget.save({},
      success: => @renderBucket(bucket, true)
      error: => alert("Couldn't save income bucket")
    )

  bucketRemoved: ->
    @budget.save()

  renderSummary: ->
    @$(".category").html(JST["backbone/templates/income_summary"](
      budgeted: @formatMoney(@model.budgeted())
      collapsed: @categoryIsCollapsed()
    ))

  renderBucket: (bucket, focus) ->
    view = @newView(BudgetApp.Views.IncomeBucketView, model: bucket, budget: @budget)
    @$(".buckets").append(view.render().el)
    $(view.el).find("input[name=name]").focus() if(focus)
    $(view.el).data("view", view)

  renderBuckets: ->
    @model.buckets().each (bucket) => @renderBucket(bucket)
    @$(".buckets").sortable(axis: "y")

  render: ->
    $(@el).html(@template(collapsed: @categoryIsCollapsed()))
    @renderSummary()
    @renderBuckets()
    @

