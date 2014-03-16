class Mule.Routers extends Backbone.Router
  routes:
    '':'index'

  initialize: ->
    @collection = new Mule.Collections.Rooms()

  index: ->
    view = new Mule.Views.RoomsIndex(collection: @collection)
    $('#wrapper').html(view.render().el)