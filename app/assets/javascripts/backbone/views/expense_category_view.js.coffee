class BudgetApp.Views.ExpenseCategoryView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/expense_category"]
  className: "category-wrapper"

  events:
    "change input[name=name]": "nameChanged"
    "click [data-add-expense]": "addNewExpenseBucket"
    "click [data-delete-category]": "deleteCategory"
    "click [data-configure-category]": "configureCategory"
    "click [data-add-bucket]": "addNewExpenseBucket"
    "click [data-collapse]": "toggleCollapseCategory"
    "sortupdate .buckets": "updateSortOrder"

  initialize: ->
    super()
    @listenTo(@model, "change", @renderSummary)
    @listenTo(@model.buckets(), "add", @newBucketAdded)
    @listenTo(@model.buckets(), "destroy", @bucketRemoved)

  updateSortOrder: =>
    #buckets = ({id: $(el).data("view").model.id, sort_order: i + 1} for el, i in @$(".buckets > div"))
    #@model.patch(buckets_attributes: buckets)

  nameChanged: =>
    @model.name(@$("input[name=name]").val())
    @model.save()

  addNewExpenseBucket: ->
    @model.buckets().add({})
    @configureCategory()

  newBucketAdded: (bucket) =>
    bucket.save({},
      success: =>
        @renderBucket(bucket, true)
        @updateSortOrder()

      error: =>
        alert("Couldn't save new bucket")
    )

  bucketRemoved: =>
    @model.collection.budget.save()

  deleteCategory: =>
    if confirm("Are you sure?")
      @model.destroy()
      @remove()

  configureCategory: =>
    left = if parseInt(@$(".category-container").css("left")) < 0 then 0 else -250
    @$(".category-container").animate({left: left}, 250)

  renderSummary: =>
    @$(".category").html(JST["backbone/templates/expense_category_summary"](
      name: @model.name()
      budgeted: @formatMoney(@model.budgeted())
      spent: @formatMoney(@model.spent())
      remaining: @formatMoney(@model.remaining())
    )).inlineEditable()

    if @model.remaining() == 0
      @$(".category").addClass("cleared")
    else
      @$(".category").removeClass("cleared")

  renderBucket: (bucket, focus) =>
    view = @newView(BudgetApp.Views.ExpenseBucketView, model: bucket)
    @$(".buckets").append(view.render().el)
    $(view.el).find("input[name=name]").focus() if focus
    $(view.el).data("view", view)

  renderBuckets: ->
    @model.buckets().each (bucket) => @renderBucket(bucket)
    @$(".buckets").sortable(axis: "y")

  render: ->
    $(@el).html(@template(name: @model.name(), collapsed: @isCollapsed())).inlineEditable()
    @renderSummary()
    @renderBuckets()
    @

