class Mule.Views.InventoryIndex extends Backbone.View

  template: JST['inventory/index']

  className: 'inventory'

  events:
    'click .addRoom': 'addRoom'
    'click #logout': 'logout'
    'click #finish': 'summary'

  logout: ->
    @session = new Mule.Models.Session(@user.attributes).destroy()
    window.location.href = "/"

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router

    @user = new Mule.Models.User(fetch: true)
    @app.user = @user
    $('body').animate({scrollTop:0},0);
    @listenTo(@user, 'change', @render)
    @totalFurnitureCount = 0

  summary: (e) ->
    e.preventDefault()
    @router.navigate('summary', trigger: true)
    return

  render: ->
    console.log 'rendering'
    @$el.html(@template(user: @user))
    @renderTable()
    @appendRooms()
    @totalFurnitureCounter = @.$el.find('.furniture-for-house')
    @

  _incrementTotal: (amount) ->
    if @totalFurnitureCount == 0 and amount > 0
       @totalFurnitureCount += amount
    else
      if @totalFurnitureCount > 0 then @totalFurnitureCount += amount

    @totalFurnitureCounter.text(@totalFurnitureCount.toString())

  _decrementTotal: (amount) ->
    @totalFurnitureCount -= amount
    @totalFurnitureCounter.text(@totalFurnitureCount.toString())


  renderTable: ->
    _.each @_itemTypes(), (item) =>
      itemView = new Mule.Views.Item(app: @app, name: item)
      @$('.summary-table > tbody:last').append(itemView.render().el);
    @_wrapCellGroupsWithRow(@$('td'))

  addRoom: (e) ->
    e.preventDefault()
    #TODO replace this with @user.rooms.create() . it will POST to the API, api should add a room associated to the user
    room = new Mule.Models.Room()
    @user.rooms.add(room)

  appendRooms: ->
    $target = @$('.rooms-wrapper')
    @user.rooms.each (room) =>
      room.view?.remove()
      room.view = new Mule.Views.Room(app: @app, delegate:@, model: room)
      $target.append(room.view.render().el)

  _startTour: ->
    $tour = new Tourist.Tour
      successStep: @_successStep()
      tipClass: "Bootstrap"
      tipOptions:
        showEffect: "slidein"
      steps: @_steps()
      stepOptions:
        view: @
    run = () ->
      $tour.start()
    setTimeout(run, 500)

  _checkIfTutorialCompleted: ->
    unless (window.localStorage.tutorialCompleted == 'true')
      @_startTour()

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
      content: "<p>Lets get started!</p>" + "<p>" + "  Enter the most suitable name for your room, when you are done, click "+ "<b>" + "Next Step"+ "</b>" + "</p>"
      highlightTarget: true
      nextButton: true
      my: "bottom left"
      at: "top center"
      setup: (tour, options) ->
        options.view.bind "showRoom", @showRoom
        target: options.view.$el.find('.room-name-input')
      teardown: (tour, options) ->
        options.view.unbind "showRoom", @showRoom
        return
      bind: ["showRoom"]
      showRoom: (tour) ->
        tour.next()
        return
    }
    {
      content: "<p>Awesome!</p>" + "<p>" + "  Now for the fun part :) Click the arrow to reveal the furniture options for your room" + "</p>"
      highlightTarget: true
      my: "bottom left"
      at: "top center"
      setup: (tour, options) ->
        options.view.bind "showCategory", @showCategory
        target: options.view.$el.find('.glyphicon-chevron-right')
      teardown: (tour, options) ->
        options.view.unbind "showCategory", @showCategory
        return
      bind: ["showCategory"]
      showCategory: (tour) ->
        waitForDrawer = () ->
          tour.next()
          return
        setTimeout(waitForDrawer, 500)
    }
    {
      content: "<p>Super!</p>" + "<p>" + "  Here we see the broad categories of furnitute options to select from, click the arrow to reveal the options for " + "<b>" + "Beds" + "</b>" + "</p>"
      highlightTarget: true
      my: "top left"
      at: "bottom left"
      setup: (tour, options) ->
        options.view.bind "incrementItemCount", @incrementItemCount
        target: options.view.$el.find('.category-reveal')
      teardown: (tour, options) ->
        options.view.unbind "incrementItemCount", @incrementItemCount
        return
      bind: ["incrementItemCount"]
      incrementItemCount: (tour) ->
        waitForDrawer = () ->
          tour.next()
          return
        setTimeout(waitForDrawer, 500)
    }
    {
      content: "<p>Wahoo!</p>" + "<p>" + "  This is the good stuff. Click on the plus button to increase the furniture count by one" + "</p>"
      highlightTarget: true
      my: "top left"
      at: "bottom left"
      setup: (tour, options) ->
        options.view.bind "explainFurnitureCount", @explainFurnitureCount
        target: $(_.first(options.view.$el.find('.increment')))
      teardown: (tour, options) ->
        options.view.unbind "explainFurnitureCount", @explainFurnitureCount
        topPosition = $(options.view.$el.find('.room-inventory')[0]).position().top
        $('body').animate({scrollTop:topPosition}, 600);

        return
      bind: ["explainFurnitureCount"]
      explainFurnitureCount: (tour) ->
        tour.next()
        return
    }
    {
      content: "<p>Woot!</p>" + "<p>" + "  When you add a furniture item, the total furniture item count for the room is updated" + "</p>"
      nextButton: true
      highlightTarget: true
      my: "top right"
      at: "bottom center"
      setup: (tour, options) ->
        target: options.view.$el.find('.furniture-for-room')
      teardown: (tour, options) ->
        topPosition = $(options.view.$el.find('.save-form')[0]).position().top
        $('body').animate({scrollTop:topPosition}, 600);
        return
    }
    {

      content: "<p>Yahoo!</p>" + "<p>" + "  Lets mark this room done for the moment. Just click " + "<b>" + "DONE "+ "</b>" + " to mark it ready. (P.S the big red X will delete the room)</p>"
      highlightTarget: true
      my: "bottom center"
      at: "top center"
      setup: (tour, options) ->
        options.view.bind "roomComplete", @roomComplete
        target: options.view.$el.find('.save-form')
      teardown: (tour, options) ->
        options.view.unbind "roomComplete", @roomComplete
        return
      bind: ["roomComplete"]
      roomComplete: (tour) ->
        tour.next()
        return
    }
  ]
  _successStep: ->
    content: "<p>Nice job! Now you know your way around</p>" + "<p>Take a walk around your house and add your furniture to your rooms list. When you are done just click "+ "<b>" + "Finish!" + "</b>" + "</p>"
    nextButton: true
    highlightTarget: true
    my: "bottom right"
    at: "top center"
    target: @.$el.find('.finish')
    teardown: (tour, options) ->
      window.localStorage.setItem("tutorialCompleted",true);
