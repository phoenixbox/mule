class Mule.Views.InventoryIndex extends Backbone.View

  template: JST['inventory/index']

  collection: Mule.Collections.Rooms

  events:
    'click .addRoom': '_append'
    'click .glyphicon-pencil': '_toggleEditable'

  className: 'inventory'

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router
    @

  render: ->
    @$el.html(@template())
    @_renderTable()
    @_appendChosenNumberOfRooms()
    @

  _toggleEditable: (e) ->
    e.preventDefault()
    $target = $(e.target)
    $input = $target.parents('.name').children('.room-name-input')

    $input.keydown (e) =>
      if e.keyCode == 13
        $input.attr('readonly', true)

    if $input.prop('readonly')
      $input.attr('readonly', false)
      $input.focus()

    $input.blur =>
        $input.attr('readonly', true)

  _appendChosenNumberOfRooms: ->
    rooms = parseInt(window.localStorage.roomNumber)
    @_append() for [1..rooms]

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