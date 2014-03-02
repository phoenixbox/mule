window.Mule =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  initialize: ->
    new Mule.Routers.Submissions()
    Backbone.history.start()

$(document).ready ->
  Mule.initialize()
