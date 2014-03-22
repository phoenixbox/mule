class Mule.Views.RoomsIndex extends Backbone.View

  template: JST['rooms/index']

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
    @$el.parents().children().find('.modal-backdrop').remove()
    @$el.remove()
    @router.navigate("inventory", trigger: true)