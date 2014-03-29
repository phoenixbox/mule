class Mule.Views.InventoryIndex extends Backbone.View

  template: JST['inventory/index']

  collection: Mule.Collections.Rooms

  events:
    'click .addRoom': '_append'

  className: 'inventory'

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router

  render: ->
    @_renderTableCells()
    @$el.html(@template(rooms: @_itemTypes(), itemsPerRow: @_itemsPerRow()))
    @

  _append: ->
    roomFormView = new Mule.Views.Room(app: @app)
    @$('.inventory-wrapper').append(roomFormView.render().el)

  _renderTableCells: ->
    itemView = new Mule.Views.Item(app: @app)
    @$el.find('.summary-table')

  _itemTypes: ->
    ['beds','sofas','chairs','tables','cabinets','stereos','tv\'s','computers','lamps','bookcases','mirrors','paintings','kitchen appliances','pianos', 'other']

  _itemsPerRow: ->
    # Zero based index count
    4
