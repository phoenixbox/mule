class Mule.Views.Category extends Backbone.View

  template: JST['inventory/category']

  className: "col-md-12 category"

  events:
    'click .toggle-category': 'toggle'
    'click .save-category': 'save_category'

  initialize: (options) ->
    defaults = _.pick options, "title", "room"
    _.extend @, defaults
    @model = new Mule.Models.Category(null, title: @title, room: @room)
    @delayed_update_room = _.debounce(@update_room, 1000)
    @update_count = _.debounce(@_update_count, 300)
    @render()

  render: ->
    @$el.html @template
      model: @model
      title: @title
    @render_items()
    @update_count()
    @

  _update_count: () ->
    $target = @$('.furniture-for-category')
    counts = @$('.contents .counter')
    count = _.inject counts, ((memo, el) ->
      memo + parseInt($(el).text())
    ), 0
    $target.text(count)
    @room.view.update_count()

  render_items: ->
    $target = @$(".contents")
    $target.html("")
    @Views = {}
    _.each @model.get('items'), (item) =>
      @Views[item.type] = view = new Mule.Views.Item
        item: item
        room: @room
        category: @
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
