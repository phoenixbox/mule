class Mule.Views.SummaryIndex extends Backbone.View

  template: JST['summary/index']

  className: 'summary'

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router
    @user       = @app.user
    @rooms      = @user.rooms
    @render()
    @listenTo(@user, 'change', @render)

  render: ->
    @$el.html(@template(user: @user, rooms: @rooms))
    @
