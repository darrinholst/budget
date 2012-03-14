$ ->
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
