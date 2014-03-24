class Mule.Views.InventoryIndex extends Backbone.View

  template: JST['inventory/index']

  collection: Mule.Collections.Rooms

  events:
    'click .inventory-wrapper': '_append'


  className: 'inventory'

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router
    @posessionView = new Mule.Views.Room(app: @app)
    @_addClickListers

  render: ->
    @$el.html(@template(rooms: @collection));
    @

  _append: ->
    @$('.inventory-wrapper').append(@posessionView.render().el)

  _addClickListers: =>
    $("select + label").each (e) ->
      $e.on('click', -> @prev().focus().click())