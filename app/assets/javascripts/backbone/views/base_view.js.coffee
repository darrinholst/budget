class BudgetApp.Views.BaseView extends Backbone.View
  formatDate: (date) ->
    "#{date.getUTCMonth() + 1}/#{date.getUTCDate()}/#{date.getUTCFullYear()}"

  formatMoney: (cents) ->
    ((cents || 0) / 100).toFixed(2)
