window.Mule =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  initialize: ->
    @router = new Mule.Routers(app: this)
    Backbone.history.start({pushState: true})

#   <%- render_partial 'path/to/partial' %>  ..  will render ../spine-app/views/path/to/_partial.jst.eco
#   <%- render_partial 'path/to/partial', foo: 'bar' %>  ..  will render ../spine-app/views/path/to/_partial.jst.eco
window.render_partial = ( path, options = {} ) ->
  path = path.split('/')
  path[ path.length - 1 ] = '_' + path[ path.length - 1 ]
  path = path.join('/')
  try
    JST["#{ path }"]( options )
  catch error
    "<p class='error'>Sorry, there is no partial named '#{ path }'.</p>"

$(document).ready ->
  Mule.initialize()