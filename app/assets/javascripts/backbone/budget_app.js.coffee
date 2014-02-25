#= require_self
#= require_tree ./models
#= require_tree ./templates
#= require_tree ./views
#= require_tree ./routers

window.BudgetApp =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

$ ->
  client = new Dropbox.Client({key: 'wadq0r1h7437t33'})
  Backbone.DropboxDatastore.client = client
  client.authenticate({interactive: false}, (error) -> alert('Authentication error: ' + error) if error)

  if client.isAuthenticated()
    $('.signed-in').show()
    $('.signed-out').hide()
    window.router = new BudgetApp.Routers.Router()
    Backbone.history.start(pushState: true)
  else
    $('.signed-in').hide()
    $('.signed-out').show()

  $(document).on('click', '#sign-in', ->
    client.authenticate() unless client.isAuthenticated()
  )

  $(document).on('click', '#sign-out', ->
    client.signOut()
    location.reload()
  )

