class Mule.Views.Category extends Backbone.View

  template: JST['inventory/category']

  className: "col-md-12 category"

  events:
    'click .toggle-category': 'toggle'
    'click .save-category': 'save_category'
    'click .decrement': 'updateCounters'
    'click .increment': 'updateCounters'

  initialize: (options) ->
    defaults = _.pick options, "title", "room"
    _.extend @, defaults
    @model = new Mule.Models.Category(title: @title)
    @delayed_update_room = _.debounce(@update_room, 1000)
    @render()
    @listenTo(@model, 'change', @render)

  render: ->
    @$el.html @template
      model: @model
      title: @title
    @render_items()
    @

  item_form_segment: JST['inventory/_item_form_segment']
  sub_item_form_segment: JST['inventory/_sub_item_form_segment']

  render_items: ->
    $target = @$(".contents")
    $target.html("")
    @Views = {}
    # THIS IS THE OLD TEMPLATE LOGIC :)
    # can probably be refactored
    _.each @model.get('items'), (item) =>
      if _.isObject(item)
        title = _.first(_.keys(item))
        subItems = item[title]
        @Views[item] = view = @sub_item_form_segment
          item: title
          options: subItems
      else
        @Views[item] = view = @item_form_segment(item: item)
      $target.append view


  updateCounters: (e) ->

  update_room: (e) ->
    $target = $(e.currentTarget)
    attr = $target.attr('name')
    value = @_get_value($target)
    @model.set(attr, value)
    @model.persist()

  _get_value: (element) ->
    element.val() if element.is('input')

  toggle: (e) ->
    if @open() then @close_drawer() else @open_drawer()
    debugger
    #TODO FIX THIS @scrollToTargetPosition($(e.target).position().top)

  open: ->
    @$('.category-dropdown').is(':visible')

  open_drawer: (e) =>
    @$('.glyphicon-chevron-right').removeClass('glyphicon-chevron-right').addClass('glyphicon-chevron-down')
    @$('.category-dropdown').show()

  close_drawer: (e) ->
    @$('.glyphicon-chevron-down').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-right')
    @$('.category-dropdown').hide()


  #   targetScrollPosition = $target.parents('.row').position().top + $target.position().top
  #   @_scrollToTargetPosition(targetScrollPosition)

  # save_category: (e) ->
  #   e.preventDefault()
  #   $target = $(e.target)
  #   $chevron = $target.parents('.category-container').find('.glyphicon-chevron-down')
  #   $chevron.click()

  scrollToTargetPosition: (targetPosition) ->
    $('body').animate({scrollTop:targetPosition}, 600);
