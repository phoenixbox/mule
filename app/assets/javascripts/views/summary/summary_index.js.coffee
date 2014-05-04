class Mule.Views.SummaryIndex extends Backbone.View

  template: JST['summary/index']

  className: 'summary'

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router
    @user       = @app.user
    @rooms      = @user.rooms
    @_render = _.throttle(@render, 100)
    @listenTo(@user, 'change', @_render)
    @_render()

  render: ->
    @$el.html(@template(user: @user, rooms: @rooms))
    @
