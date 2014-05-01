class Mule.Views.Category extends Backbone.View

  template: JST['inventory/category']

  className: "col-md-12 category"

  events:
    'click .toggle-category': '_toggleCategory'
    'click .save-category': '_doneWithCategory'
    'click .decrement': '_updateCounters'
    'click .increment': '_updateCounters'

  initialize: (options) ->
    defaults = _.pick options, "title", "columnLayout"
    _.extend @, defaults
    @category = @model.categoryOptions[@title]
    @delayed_update_room = _.debounce(@update_room, 1000)
    @render()

  render: ->
    @$el.html @template
      model: @model
      title: @title
      columnLayout: @columnLayout
      category: @category

  update_room: (e) ->
    $target = $(e.currentTarget)
    attr = $target.attr('name')
    value = @_get_value($target)
    @model.set(attr, value)
    @model.persist()

  _get_value: (element) ->
    element.val() if element.is('input')

  # open: ->
  #   @$('.toggle-room').hasClass('open')
  #
  # toggleDrawer: (e) ->
  #   $target = $(e.target)
  #   if @open() then @close_drawer() else @open_drawer()
  #   @_scrollToTargetPosition($(e.target).position().top)
  #
  # open_drawer: (e) =>
  #   @$('.toggle-room').addClass('open')
  #   @$('.contents-form').addClass('open')
  #
  # close_drawer: (e) ->
  #   @$('.toggle-room').removeClass('open')
  #   @$('.contents-form').removeClass('open')

  # _toggleCategory: (e) ->
  #   e.preventDefault()
  #   @delegate.trigger("incrementItemCount")
  #   $target = $(e.target)
  #   $categoryDrawer = $target.parents('.category-container').children('.category-dropdown')
  #   @_toggleDrawer($categoryDrawer, $target)
  #
  #   targetScrollPosition = $target.parents('.row').position().top + $target.position().top
  #   @_scrollToTargetPosition(targetScrollPosition)

  # _doneWithCategory: (e) ->
  #   e.preventDefault()
  #   $target = $(e.target)
  #   $chevron = $target.parents('.category-container').find('.glyphicon-chevron-down')
  #   $chevron.click()

  _scrollToTargetPosition: (targetPosition) ->
    $('body').animate({scrollTop:targetPosition}, 600);
