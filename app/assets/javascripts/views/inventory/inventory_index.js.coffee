class Mule.Views.InventoryIndex extends Backbone.View

  template: JST['inventory/index']

  collection: Mule.Collections.Rooms

  events:
    'click .inventory-wrapper': '_test'

  className: 'inventory'

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router
    # @collection.on('reset', @render, this)

  render: ->
    @$el.html(@template(rooms: @collection));
    @

  _test: ->
    alert('Keep going, remember you are sprinting')