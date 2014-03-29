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
    @$el.html(@template())
    @_renderTable()
    @

  _append: ->
    roomFormView = new Mule.Views.Room(app: @app)
    @$('.inventory-wrapper').append(roomFormView.render().el)

  _renderTable: ->
    _.each @_itemTypes(), (item) =>
      itemView = new Mule.Views.Item(app: @app, name: item)
      @$('.summary-table > tbody:last').append(itemView.render().el);
    @_wrapCellGroupsWithRow(@$('td'))

  _itemTypes: ->
    ['beds','sofas','chairs','tables','cabinets','stereos','tv\'s','computers','lamps','bookcases','mirrors','paintings','appliances','pianos', 'other']

  _itemsPerRow: ->
    5

  _desiredNumberOfRows: (numberOfCells) ->
    numberOfCells/@_itemsPerRow()

  _wrapCellGroupsWithRow: (cells) ->
    numberOfRows = @_desiredNumberOfRows(cells.length)
    $(cells.splice(0,5)).wrapAll( "<tr/>") for [1..numberOfRows]