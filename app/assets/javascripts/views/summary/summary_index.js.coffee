class Mule.Views.SummaryIndex extends Backbone.View

  template: JST['summary/index']

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router
    @user       = @app.user
    @user       = @app.user
    @listenTo(@user, 'change', @render)

  render: ->
    debugger
    @$el.html(@template(user: @user, rooms: @user.rooms))
    @
