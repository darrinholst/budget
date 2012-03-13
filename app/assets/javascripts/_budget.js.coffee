$ ->
  $(".edit-budget").on "click", ".bucket .add", -> alert("add a bucket")
  $(".edit-budget").on "click", ".category .add", -> alert("add a category mr fancy pants")
  $(".edit-budget").on "click", ".bucket .delete", -> alert("delete a bucket")
  $(".edit-budget").on "click", ".category .delete", -> alert("delete a category mr fancy pants")

  sortable_options =
    axis: 'y'
    helper: 'clone'
    placeholder: 'placeholder'
    forcePlaceholderSize: true

  $(".buckets, .expenses").sortable(sortable_options)
