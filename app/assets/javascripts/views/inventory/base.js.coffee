class Mule.Views.Drawer extends Backbone.View

  events:
    'click .toggle-room': 'toggleRoom'

  open: ->
    @$('.toggle-room').hasClass('open')

  toggleRoom: (e) ->
    $target = $(e.target)
    if @open() then @close_drawer() else @open_drawer()
    @_scrollToTargetPosition($(e.target).position().top)

  open_drawer: (e) =>
    @$('.toggle-room').addClass('open')
    @$('.contents-form').addClass('open')

  close_drawer: (e) ->
    @$('.toggle-room').removeClass('open')
    @$('.contents-form').removeClass('open')

  _scrollToTargetPosition: (targetPosition) ->
    $('body').animate({scrollTop:targetPosition}, 600);
