class BudgetApp.Views.BudgetIncomeView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget_income"]
  className: "income"

  events:
    "click [data-add-income]": "addNewIncomeBucket"
    "sortupdate .buckets": "updateSortOrder"

  initialize: ->
    @collection.on "change", @renderSummary
    @collection.on "remove", @renderSummary
    @collection.on "add", @newBucketAdded

  updateSortOrder: =>
    buckets = ({id: $(el).data("view").model.id, sort_order: i + 1} for el, i in @$(".bucket"))
    @model.save(income_buckets_attributes: buckets)

  addNewIncomeBucket: ->
    @collection.add({})

  newBucketAdded: (bucket) =>
    bucket.save({},
      success: (bucket) =>
        @renderBucket(bucket, true)

      error: =>
        alert("Couldn't save income bucket")
    )

  renderSummary: =>
    @$(".category").html(JST["backbone/templates/budget_income_summary"](
      budgeted: @formatMoney(@collection.budgeted())
    ))

  renderBucket: (bucket, focus) =>
    view = new BudgetApp.Views.BudgetIncomeBucketView(model: bucket)
    @$(".buckets").append(view.render().el)
    $(view.el).find("input[name=name]").focus() if(focus)
    $(view.el).data("view", view)

  renderBuckets: ->
    @collection.each (bucket) => @renderBucket(bucket)
    @$(".buckets").sortable(axis: "y")

  render: ->
    $(@el).html(@template())
    @renderSummary()
    @renderBuckets()
    @
