window.Mule =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  initialize: ->
    @user = new Mule.Models.User()
    @session = new Mule.Models.Session(@user.attributes)
    @router = new Mule.Routers(app: this)
    Backbone.history.start({pushState: true})

window.render_partial = ( path, options = {} ) ->
  path = path.split('/')
  path[ path.length - 1 ] = '_' + path[ path.length - 1 ]
  path = path.join('/')
  try
    JST["#{ path }"]( options )
  catch error
    "<p class='error'>Sorry, there is no partial named '#{ path }'.</p>"

$(document).ready ->
  # new FastClick(document.body)
  Mule.initialize()
