class Mule.Views.Room extends Backbone.View

  template: JST['inventory/room']

  className: 'room'

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router

  render: ->
    @$el.html(@template);
    @
