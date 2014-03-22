class Mule.Routers extends Backbone.Router
  routes:
    '':'index'
    'inventory': 'inventory'

  initialize: (options)->
    @app = options.app
    @app.router = this
    @collection = new Mule.Collections.Rooms()

  index: ->
    view = new Mule.Views.RoomsIndex(app: @app, collection: @collection)
    $('#wrapper').html(view.render().el)

  inventory: ->
    view = new Mule.Views.InventoryIndex(app: @app, collection: @collection)
    $('#wrapper').html(view.render().el)