class Mule.Views.InventoryIndex extends Backbone.View

  template: JST['inventory/index']

  collection: Mule.Collections.Rooms

  events:
    'click .addRoom': '_append'


  className: 'inventory'

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router
    @_addClickListers

  render: ->
    @$el.html(@template(rooms: @collection));
    @

  _append: ->
    @posessionView = new Mule.Views.Room(app: @app)
    @$('.inventory-wrapper').append(@posessionView.render().el)