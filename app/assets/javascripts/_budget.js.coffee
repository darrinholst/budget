$ ->
  $(".edit-budget").on "click", ".bucket .add", -> alert("add a bucket")
  $(".edit-budget").on "click", ".category .add", -> alert("add a category mr fancy pants")
  $(".edit-budget").on "click", ".bucket .delete", -> alert("delete a bucket")
  $(".edit-budget").on "click", ".category .delete", -> alert("delete a category mr fancy pants")

  $(".buckets, .expenses").sortable
    axis: 'y'
    helper: 'original'
    placeholder: 'placeholder'
    start: (event, ui) ->
      ui.placeholder.height(ui.item.data["originalHeight"])
      ui.placeholder.addClass(ui.item.attr('class'))

  $(".buckets .bucket, .expenses .category-container").on "mousedown", ->
    $(this).data["originalHeight"] = $(this).outerHeight() unless $(this).data["originalHeight"]

  $(".buckets .bucket, .expenses .category-container").on "mouseup", ->
    $(this).data["originalHeight"] = undefined
