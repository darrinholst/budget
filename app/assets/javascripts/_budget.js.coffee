$ ->
  addBucket = (event) ->
    bucket = $(this).parents(".bucket")
    bucket.clone().insertAfter(bucket)

  deleteBucket = (event) ->
    if confirm("Are you sure?")
      $(this).parents(".bucket").remove()

  addCategory = (event) ->
    category = $(this).parents(".category-container")
    category.clone().insertAfter(category)

  deleteCategory = (event) ->
    if confirm("Are you sure?")
      $(this).parents(".category-container").remove()

  $(".edit-budget").on "click", ".bucket .add", addBucket
  $(".edit-budget").on "click", ".category .add", addCategory
  $(".edit-budget").on "click", ".bucket .delete", deleteBucket
  $(".edit-budget").on "click", ".category .delete", deleteCategory

