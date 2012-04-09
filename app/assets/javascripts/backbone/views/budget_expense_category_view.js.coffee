class BudgetApp.Views.BudgetExpenseCategoryView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/budget_expense_category"]
  className: "category-container"

  events:
    "change input[name=name]": -> @model.name(@$("input[name=name]").val())

  initialize: ->
    @model.bind("change", @sync)

  sync: =>
    @model.save()
    @render()

  renderCategory: ->
    @$(".category").html(JST["backbone/templates/budget_expense_category_summary"](
      name: @model.name()
      budgeted: @formatMoney(@model.budgeted())
      spent: @formatMoney(@model.spent())
      remaining: @formatMoney(@model.remaining())
    ))


  renderBuckets: ->
    @model.buckets().each (bucket) =>
      @$(".buckets").append(new BudgetApp.Views.BudgetExpenseBucketView(model: bucket).render().el)

    @$(".buckets").sortable(axis: "y")

  render: ->
    $(@el).html(@template())
    @renderCategory()
    @renderBuckets()
    @
