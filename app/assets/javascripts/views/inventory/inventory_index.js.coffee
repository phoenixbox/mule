class Mule.Views.InventoryIndex extends Backbone.View

  template: JST['inventory/index']

  className: 'inventory'

  events:
    'click .add-room': 'addRoom'
    'click #logout': 'logout'
    'click #finish': 'summary'

  logout: ->
    @session.destroy()
    window.location.href = "/"

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router
    @user       = @app.user
    @session    = @app.session

    $('body').animate({scrollTop:0},0);
    @render()
    @listenTo(@user, 'change', @render)
    @listenTo(@user.rooms, 'add remove', @render)
    @totalFurnitureCount = 0

  summary: (e) ->
    e.preventDefault()
    @router.navigate('summary', trigger: true)
    return

  render: ->
    console.log 'rendering '
    @$el.html(@template(user: @user))
    @appendRooms()
    @totalFurnitureCounter = @.$el.find('.furniture-for-house')
    # @_checkIfTutorialCompleted()
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

  addRoom: (e) ->
    e.preventDefault()
    @user.rooms.create()

  appendRooms: ->
    $target = @$('.rooms-wrapper')
    @user.rooms.each (room) =>
      room.view?.remove()
      room.view = new Mule.Views.Room(app: @app, delegate: @, model: room)
      $target.append(room.view.el)

  _checkIfTutorialCompleted: ->
    unless window.localStorage.tutorialCompleted == 'true'
      new Mule.TourGuide(this)
