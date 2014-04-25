class Mule.Views.Room extends Backbone.View

  template: JST['inventory/category']

  className: "col-md-12 category"

  events:
    'click .toggle-category': '_toggleCategory'
    'click .save-category': '_doneWithCategory'
    'click .decrement': '_updateCounters'
    'click .increment': '_updateCounters'

  initialize: (options) ->
    @app        = options.app
    @delegate   = options.delegate
    @router     = @app.router
    @user       = @app.user
    @delayed_update_room = _.debounce(@update_room, 1000)
    @render()

  render: ->
    @$el.html(@template(model: @model, categories: @categoryOptions(), view: @))
    @rename_room()
    @roomFurnitureCounter = @.$el.find('.furniture-for-room')
    @

  update_room: (e) ->
    $target = $(e.currentTarget)
    attr = $target.attr('name')
    value = @_get_value($target)
    @model.set(attr, value)
    @model.persist()

  _get_value: (element) ->
    element.val() if element.is('input')

  _updateCounters: (e) ->
    $target = $(e.target)

    $itemCounter = $target.parents('.quantity').children('.counter')
    $itemCounterValue = parseInt($itemCounter.text())

    $categoryCounter = $target.parents('.category-container').children('.category-header').find('.counter')
    $categoryCounterValue = parseInt($categoryCounter.text())

    if $target.is('.decrement')
      if $itemCounterValue > 0
        $itemCounterValue -=1
        if $categoryCounterValue > 0 then $categoryCounterValue -=1
        if @roomFurnitureCount > 0 then @roomFurnitureCount -=1
        @delegate._incrementTotal(-1)
    else
      @delegate.trigger("explainFurnitureCount")
      $itemCounterValue += 1
      $categoryCounterValue +=1
      @roomFurnitureCount +=1
      @delegate._incrementTotal(+1)

    $itemCounter.text($itemCounterValue.toString())
    $categoryCounter.text($categoryCounterValue.toString())
    @roomFurnitureCounter.text(@roomFurnitureCount.toString())

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

  _toggleCategory: (e) ->
    e.preventDefault()
    @delegate.trigger("incrementItemCount")
    $target = $(e.target)
    $categoryDrawer = $target.parents('.category-container').children('.category-dropdown')
    @_toggleDrawer($categoryDrawer, $target)

    targetScrollPosition = $target.parents('.row').position().top + $target.position().top
    @_scrollToTargetPosition(targetScrollPosition)

  _doneWithCategory: (e) ->
    e.preventDefault()
    $target = $(e.target)
    $chevron = $target.parents('.category-container').find('.glyphicon-chevron-down')
    $chevron.click()

  _scrollToTargetPosition: (targetPosition) ->
    $('body').animate({scrollTop:targetPosition}, 600);

  _toggleDrawer: (drawer, target) ->
    drawer.slideToggle
      duration: 200
      complete: ->
        if drawer.is(':visible')
          target.addClass('glyphicon-chevron-down').removeClass('glyphicon-chevron-right')
        else
          target.addClass('glyphicon-chevron-right').removeClass('glyphicon-chevron-down')
