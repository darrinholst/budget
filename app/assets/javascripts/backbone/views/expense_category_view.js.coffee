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

  initialize: (options) ->
    super(options)
    @listenTo(@model, "change", @renderSummary)
    @listenTo(@model.buckets(), "add", @newBucketAdded)
    @listenTo(@model.buckets(), "destroy", @bucketRemoved)

  updateSortOrder: ->
    ids = ($(el).data('view').model.cid for el in @$('.buckets > div'))
    @model.buckets().models = @model.buckets().sortBy((bucket) -> ids.indexOf(bucket.cid))
    @budget.save()

  nameChanged: ->
    @model.name(@$("input[name=name]").val())
    @budget.save()

  addNewExpenseBucket: ->
    @model.buckets().add({})
    @configureCategory()

  newBucketAdded: (bucket) =>
    @budget.save({},
      success: =>
        @renderBucket(bucket, true)
        @updateSortOrder()

      error: =>
        alert("Couldn't save new bucket")
    )

  bucketRemoved: ->
    @budget.save()

  deleteCategory: =>
    if confirm("Are you sure?")
      @model.destroy()
      @remove()

  configureCategory: ->
    left = if parseInt(@$(".category-container").css("left")) < 0 then 0 else -250
    @$(".category-container").animate({left: left}, 250)

  renderSummary: ->
    @$(".category").html(JST["backbone/templates/expense_category_summary"](
      name: @model.name()
      budgeted: @formatMoney(@model.budgeted())
      spent: @formatMoney(@model.spent())
      remaining: @formatMoney(@model.remaining())
      collapsed: @isCollapsed()
    )).inlineEditable()

    if @model.remaining() == 0
      @$(".category").addClass("cleared")
    else
      @$(".category").removeClass("cleared")

  renderBucket: (bucket, focus) ->
    view = @newView(BudgetApp.Views.ExpenseBucketView, model: bucket, budget: @budget)
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

