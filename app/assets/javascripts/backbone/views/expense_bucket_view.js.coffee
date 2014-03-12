class BudgetApp.Views.ExpenseBucketView extends BudgetApp.Views.BaseBucketView
  template: JST["backbone/templates/expense_bucket"]

  events: ->
    _.extend super(), {
      'change input[name=spent]': 'spentChanged'
      'click [data-itemize-bucket]': 'itemizeBucket'
      'click [data-collapse]': 'toggleCollapseBucket'
      'focus input[name=spent]': 'spentFocused'
      'sortupdate .itemizations': 'updateSortOrder'
    }

  initialize: (options) ->
    super(options)
    @listenTo(@model, 'change', @renderSpent)

  updateSortOrder: ->
    ids = ($(el).data('view').model.cid for el in @$('.itemization'))
    @model.itemizations().models = @model.itemizations().sortBy((itemization) -> ids.indexOf(itemization.cid))
    @budget.save()

  itemizeBucket: ->
    @toggleCollapseBucket(event) if @bucketIsCollapsed()
    @model.itemizations().add({})
    @$(".bucket").addClass("has-itemizations")

  spentFocused: (event) ->
    @toggleCollapseBucket(event) if @bucketIsCollapsed()

  toggleCollapseBucket: (event) ->
    event.stopPropagation()
    @$(".itemizations").toggle("slide")
    @$(".collapse-bucket").toggleClass("fa-angle-down").toggleClass("fa-angle-right")
    @saveBucketCollapsedState()

  saveBucketCollapsedState: ->
    if Modernizr.localstorage
      if @bucketIsCollapsed()
        localStorage.setItem("bucket_collapsed#{@model.id}", true)
      else
        localStorage.removeItem("bucket_collapsed#{@model.id}")

  bucketIsCollapsed: ->
    @$(".collapse-bucket").hasClass("fa-angle-right")

  isBucketCollapsed: ->
    Modernizr.localstorage && 'true' == localStorage.getItem("bucket_collapsed#{@model.id}")

  spentChanged: (event) ->
    @model.spent(event.target.value)
    @budget.save()

  renderSpent: ->
    @$("input[name=spent]").val(@formatMoney(@model.spent()))
    @$("input[name=remaining]").val(@formatMoney(@model.remaining()))
    @colorize()

  render: ->
    $(@el).html(@template(
      name: @model.name()
      budgeted: @formatMoney(@model.budgeted())
      spent: @formatMoney(@model.spent())
      remaining: @formatMoney(@model.remaining())
      collapsed: @isBucketCollapsed()
      hasItemizations: @model.itemizations().any()
    )).inlineEditable()

    @newView(BudgetApp.Views.ItemizationsView, el: @$(".itemizations"), collection: @model.itemizations(), budget: @budget).render()
    @colorize()
    @

