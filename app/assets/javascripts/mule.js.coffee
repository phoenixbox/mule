window.Mule =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  initialize: ->
    @router = new Mule.Routers(app: this)
    Backbone.history.start({pushState: true})

$(document).ready ->
  Mule.initialize()