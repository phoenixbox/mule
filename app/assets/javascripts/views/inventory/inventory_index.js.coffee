class Mule.Views.InventoryIndex extends Backbone.View

  template: JST['inventory/index']

  className: 'inventory'

  totalFurnitureCount: 0

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
    @_render = _.debounce(@render, 100)
    @update_count = _.debounce(@_update_count, 500)
    @render()
#    @_checkIfTutorialCompleted()
    @listenTo(@user, 'change', @_render)
    @listenTo(@user.rooms, 'add remove', @_render)

  summary: (e) ->
    e.preventDefault()
    @router.navigate('summary', trigger: true)
    return

  render: ->
    console.log 'rendering '
    @$el.html(@template(user: @user))
    @appendRooms()
    @update_count()
    @

  addRoom: (e) ->
    e.preventDefault()
    @user.rooms.create()

  appendRooms: ->
    $target = @$('.rooms-wrapper')
    @user.rooms.each (room) =>
      room.view?.remove()
      room.view = new Mule.Views.Room(app: @app, delegate: @, model: room)
      $target.append(room.view.el)

  _update_count: () ->
    $target = @$('.furniture-for-house')
    counts = @$('.furniture-for-room')
    count = _.inject counts, ((memo, el) ->
      memo + parseInt($(el).text())
    ), 0
    $target.text(count)

  _checkIfTutorialCompleted: ->
    unless window.localStorage.tutorialCompleted == 'true'
      new Mule.TourGuide(this)