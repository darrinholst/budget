class BudgetApp.Views.BudgetExpenseCategoryView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget_expense_category"]
  className: "category-container"

  events:
    "change input[name=name]": "nameChanged"
    "click [data-add-expense]": "addNewExpenseBucket"
    "click [data-delete-category]": "deleteCategory"
    "click [data-configure-category]": "configureCategory"
    "sortupdate .buckets": "updateSortOrder"

  initialize: ->
    @model.bind "change", @renderSummary
    @model.bind "remove", @renderSummary
    @model.buckets().on "add", @newBucketAdded

  updateSortOrder: =>
    buckets = ({id: $(el).data("view").model.id, sort_order: i + 1} for el, i in @$(".bucket"))
    @model.save(buckets_attributes: buckets)

  nameChanged: =>
    @model.name(@$("input[name=name]").val())
    @model.save()

  addNewExpenseBucket: ->
    @model.buckets().add({})

  newBucketAdded: (bucket) =>
    bucket.save({},
      success: (bucket) =>
        @renderBucket(bucket, true)
        @updateSortOrder()

      error: =>
        alert("Couldn't save new bucket")
    )

  deleteCategory: =>
    if confirm("Are you sure?")
      @model.destroy()
      @remove()

  configureCategory: =>
    left = if parseInt($(@el).css("left")) < 0 then 0 else -100
    $(@el).animate({left: left}, 150)

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
    $(view.el).data("view", view)

  renderBuckets: ->
    @model.buckets().each (bucket) => @renderBucket(bucket)
    @$(".buckets").sortable(axis: "y")

  render: ->
    $(@el).html(@template(name: @model.name())).inlineEditable()
    @renderSummary()
    @renderBuckets()
    @

