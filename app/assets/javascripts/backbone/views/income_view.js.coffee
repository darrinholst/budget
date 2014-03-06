class BudgetApp.Views.IncomeView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/income"]
  className: "income-wrapper"

  events:
    "click [data-add-income]": "addNewIncomeBucket"
    "sortupdate .buckets": "updateSortOrder"
    "click [data-configure-category]": "configureIncome"
    "click [data-collapse]": "toggleCollapseCategory"

  initialize: (options) ->
    super(options)
    @listenTo(@collection, 'change', @renderSummary)
    @listenTo(@collection, 'remove', @renderSummary)
    @listenTo(@collection, 'add', @newBucketAdded)
    @listenTo(@collection, "destroy", @bucketRemoved)

  updateSortOrder: =>
    #buckets = ({id: $(el).data("view").model.id, sort_order: i + 1} for el, i in @$(".bucket"))
    #@model.patch(income_buckets_attributes: buckets)

  addNewIncomeBucket: ->
    @collection.add({})
    @configureIncome()

  newBucketAdded: (bucket) ->
    @budget.save({},
      success: => @renderBucket(bucket, true)
      error: => alert("Couldn't save income bucket")
    )

  bucketRemoved: ->
    @budget.save()

  configureIncome: ->
    left = if parseInt(@$(".income").css("left")) < 0 then 0 else -150
    @$(".income").animate({left: left}, 150)

  renderSummary: ->
    @$(".category").html(JST["backbone/templates/income_summary"](
      budgeted: @formatMoney(@collection.budgeted())
    ))

  renderBucket: (bucket, focus) ->
    view = @newView(BudgetApp.Views.IncomeBucketView, model: bucket, budget: @budget)
    @$(".buckets").append(view.render().el)
    $(view.el).find("input[name=name]").focus() if(focus)
    $(view.el).data("view", view)

  renderBuckets: ->
    @collection.each (bucket) => @renderBucket(bucket)
    @$(".buckets").sortable(axis: "y")

  render: ->
    $(@el).html(@template(collapsed: @isCollapsed()))
    @renderSummary()
    @renderBuckets()
    @

