window.Mule =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  initialize: ->
    new Mule.Routers()
    Backbone.history.start()

$(document).ready ->
  Mule.initialize()
