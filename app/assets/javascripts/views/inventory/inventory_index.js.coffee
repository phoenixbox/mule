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
    @_renderTableCells()
    @$el.html(@template(rooms: @collection))
    @

  _append: ->
    roomFormView = new Mule.Views.Room(app: @app)
    @$('.inventory-wrapper').append(roomFormView.render().el)

  _renderTableCells: ->
    itemView = new Mule.Views.Item(app: @app)
    @$el.find('.summary-table')
