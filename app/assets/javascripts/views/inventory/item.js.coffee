class Mule.Views.Item extends Backbone.View

  template: JST['inventory/item']

  className: 'room'

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router

  render: ->
    @$el.html(@template);
    @