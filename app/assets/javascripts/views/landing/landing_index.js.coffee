class Mule.Views.LandingIndex extends Backbone.View

  template: JST['landing/index']

  events:
    'click #startInventory': '_startInventory'

  className: 'rooms'

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router
    @collection.on('reset', @render, this)

  render: ->
    @$el.html(@template(room: @model));
    @

  _startInventory: (e) ->
    room_number = @.$el.find('.room-numbers').find(":selected").text()
    window.localStorage.setItem("roomNumber",room_number);
    @$el.parents().children().find('.modal-backdrop').remove()
    @$el.remove()
    @router.navigate("inventory", trigger: true)