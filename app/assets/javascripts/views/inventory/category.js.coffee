class Mule.Views.Category extends Backbone.View

  template: JST['inventory/category']

  className: "col-md-12 category"

  events:
    'click .toggle-category': 'toggle'
    'click .save-category': 'save_category'

  initialize: (options) ->
    defaults = _.pick options, "title", "room"
    _.extend @, defaults
    @model = new Mule.Models.Category(title: @title)
    @room.categories ||= {}
    @room.categories[@title] = @model
    @delayed_update_room = _.debounce(@update_room, 1000)
    @render()
    @listenTo(@model, 'change', @render)

  render: ->
    @$el.html @template
      model: @model
      title: @title
    @render_items()
    @

  render_items: ->
    $target = @$(".contents")
    $target.html("")
    @Views = {}
    _.each @model.get('items'), (item) =>
      if _.isObject(item)
        title = _.first(_.keys(item))
        subItems = item[title]
        @Views[title] = view = new Mule.Views.Item
          category: @
          room: @room
          item: title
          options: subItems
      else
        @Views[item] = view = new Mule.Views.Item
          category: @
          room: @room
          item: item
      $target.append view.$el

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
    #TODO FIX THIS @scrollToTargetPosition($(e.target).position().top)

  open: ->
    @$('.category-dropdown').is(':visible')

  open_drawer: (e) =>
    @$('.glyphicon-chevron-right').removeClass('glyphicon-chevron-right').addClass('glyphicon-chevron-down')
    @$('.category-dropdown').show()

  close_drawer: (e) ->
    @$('.glyphicon-chevron-down').removeClass('glyphicon-chevron-down').addClass('glyphicon-chevron-right')
    @$('.category-dropdown').hide()

  save_category: (e) ->
    e.preventDefault()
    @close_drawer()

  scrollToTargetPosition: (targetPosition) ->
    $('body').animate({scrollTop:targetPosition}, 600);
