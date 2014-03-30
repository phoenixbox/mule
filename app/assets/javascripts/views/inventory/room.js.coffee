class Mule.Views.Room extends Backbone.View

  template: JST['inventory/room']

  className: 'room'

  events:
    'click .toggle': '_toggleRoom'

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router

  render: ->
    @$el.html(@template);
    @

  _toggleRoom: (e) =>
    $target = $(e.target)
    $roomDrawer = $target.parents('.room-inventory').children('.contents-form')
    $roomDrawer.slideToggle
      duration: 0
      complete: ->
        if $roomDrawer.is(':visible')
          $target.addClass('glyphicon-chevron-down').removeClass('glyphicon-chevron-right')
        else
          $target.addClass('glyphicon-chevron-right').removeClass('glyphicon-chevron-down')