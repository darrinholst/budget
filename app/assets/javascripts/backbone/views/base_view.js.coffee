class BudgetApp.Views.BaseView extends Backbone.View
  formatDate: (date) ->
    "#{@_pad(date.getUTCMonth() + 1, 2)}/#{@_pad(date.getUTCDate(), 2)}/#{date.getUTCFullYear()}"

  formatMoney: (cents) ->
    ((cents || 0) / 100).toFixed(2)

  _pad: (number, length) ->
    number = "#{number}"

    while number.length < length
      number = "0#{number}"

    number

  toggleCollapseCategory: =>
    @$(".buckets").toggle("slide")
    @$(".collapse-category").toggleClass("icon-angle-down").toggleClass("icon-angle-right")
    @saveCollapsedState()

  saveCollapsedState: =>
    if Modernizr.localstorage
      if @$(".collapse-category").hasClass("icon-angle-right")
        localStorage.setItem("collapsed#{@model.id}", true)
      else
        localStorage.removeItem("collapsed#{@model.id}")

  isCollapsed: =>
    Modernizr.localstorage && 'true' == localStorage.getItem("collapsed#{@model.id}")

