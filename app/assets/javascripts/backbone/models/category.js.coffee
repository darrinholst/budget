BudgetApp.Models.Category = Backbone.RelationalModel.extend
  relations: [
    {
      type: Backbone.HasMany
      key: 'buckets'
      relatedModel: 'BudgetApp.Models.Bucket'
      collectionType: 'BudgetApp.Collections.Buckets'
      includeInJSON: false
      reverseRelation:
        key: 'category'
        includeInJSON: false
    }
  ]

  initialize: ->
    @bind "change", => _.each(@getRelations(), (relation) -> relation.related && relation.related.trigger("change"))

  name: (newValue) -> if newValue then @set("name", newValue) else @get("name")
  buckets: -> @get("buckets")
  budgeted: -> @buckets().budgeted()
  spent: -> @buckets().spent()
  remaining: -> @buckets().remaining()

class BudgetApp.Collections.Categories extends Backbone.Collection
  model: BudgetApp.Models.Category

  url: -> "#{@.budget.url()}/category"
  budgeted: -> @models.reduce ((memo, category) -> memo + category.budgeted()), 0
  remaining: -> @models.reduce ((memo, category) -> memo + category.remaining()), 0
