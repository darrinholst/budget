class BudgetApp.Views.ItemizationsView extends BudgetApp.Views.BaseView
  template: JST["backbone/templates/itemizations"]

  initialize: ->
    @collection = @model.itemizations()
    @collection.add(new BudgetApp.Models.Itemization())
    $('.popover.in').prev('.itemize').popover('hide')

  renderItemization: (itemization) =>
    view = new BudgetApp.Views.ItemizationView(model: itemization)
    @$(".itemizations").append(view.render().el)

  renderItemizations: ->
    @collection.each (itemization) => @renderItemization(itemization)

  render: ->
    $(@el).html(@template())
    @renderItemizations()

    $target = @options['target']

    $target.popover(
      title: '<span class="text-info"><strong>Itemizations</strong></span><a href="#" class="pull-right" data-close-popover>x<a>'
      html: true
      content: @el
      placement: 'right'
      trigger: 'manual'
    )

    $target.attr("title", $.attr("data-original-title")).attr("data-original-title", '')
    $target.popover('show')
    @

