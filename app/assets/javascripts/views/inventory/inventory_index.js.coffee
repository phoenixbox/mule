class Mule.Views.InventoryIndex extends Backbone.View

  template: JST['inventory/index']

  collection: Mule.Collections.Rooms

  events:
    'click .addRoom': '_append'
    'click #logo' : '_startTour'

  className: 'inventory'

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router
    @

  render: ->
    @$el.html(@template())
    @_renderTable()
    @_appendChosenNumberOfRooms()
    # @_startTour()
    @

  _startTour: ->
    tour = new Tourist.Tour(
      successStep: @_successStep()
      tipClass: "Bootstrap"
      tipOptions:
        showEffect: "slidein"
      steps: @_steps()
      stepOptions:
        # pass in the view so the tour steps can use it
        view: @
    )
    tour.start()

  _appendChosenNumberOfRooms: ->
    rooms = parseInt(window.localStorage.roomNumber)
    @_append() for [1..rooms]
    @_toggleFirstRoom()

  _toggleFirstRoom: ->
    $(_.first(@.$el.find('.glyphicon-chevron-right'))).click()

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

  _steps: -> [
    {
      content: "<p>Lets start by naming your first room</p>" + "<p class=\"action\">" + "  Click the pencil and type in your room's name." + "</p>"
      highlightTarget: true
      my: "bottom center"
      at: "top center"
      target: @.$el.find('.glyphicon-pencil')
      setup: (tour, options) ->
        # We can control the view passed in via stepOptions
        # options.view.reset()
        options.View.bind "roomNameEdited", @_roomNameEdited
        # options.view.enable()
        return
      teardown: (tour, options) ->
        # Disallow more kitten selection
        # options.view.disable()
        options.view.unbind "roomNameEdited", @_roomNameEdited
        return
      # a function name in bind allows you to reference
      # it with `this` in setup and teardown
      bind: ["roomNameEdited"]
      _roomNameEdited: (tour, options, view, kitten) ->
        # User clicks a kitten, we move to the next step
        tour.next()
        return
    }
    {
      # Step 2
      content: "<p>Lets add some items of furniture to your room</p>" + "<p class=\"action\">" + "Click the arrow to see the furniture options" + "</p>"
      highlightTarget: true
      nextButton: true
      my: "bottom center"
      at: "top center"
      setup: (tour, options) ->
        # we can contextually modify the step's configuraton.
        # Whatever returned here will override the initial
        # values. Here we point to the user's kitten.
        target: @.$el.find('.glyphicon-chevron-right')
      teardown: (tour, options) ->
        # Enable so the user click kittens after the tour
        options.view.enable()
        return
    }
  ]
  _successStep: ->
    # Final step after a successful run through
    content: "<p>Nice job, this is a success step.</p>" + "<p>Notice you can now choose either kitten.</p>"
    closeButton: true
    nextButton: true
    highlightTarget: true
    my: "left center"
    at: "right center"
    target: @.$el.find('.glyphicon-pencil')