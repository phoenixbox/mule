class Mule.Views.Room extends Backbone.View

  template: JST['inventory/room']

  className: 'room room-inventory'

  placeholder: 'Room'

  events:
    'click .save-form': 'done_with_room'
    'click .toggle-room': 'toggleRoom'
    'click .remove-room': 'removeRoom'
    'keyup .room-name-input': 'rename_room'

  initialize: (options) ->
    @app        = options.app
    @delegate   = options.delegate
    @router     = @app.router
    @user       = @app.user
    @model.view = @
    @update_count = _.debounce(@_update_count, 400)
    @delayed_update_room = _.debounce(@update_room, 1000)
    @render()

  render: ->
    @$el.html @template(model: @model)
    @rename_room()
    @render_categories()
    @

  _update_count: () ->
    $target = @$('.furniture-for-room')
    counts = @$('.furniture-for-category')
    count = _.inject counts, ((memo, el) ->
      memo + parseInt($(el).text())
    ), 0
    $target.text(count)
    @delegate.trigger("explainFurnitureCount")
    @delegate.update_count()

  update_room: (e) ->
    $target = $(e.currentTarget)
    attr = $target.attr('name')
    value = $target.val() if $target.is('input')
    @model.set(attr, value)
    @model.persist()

  removeRoom: (e) ->
    e.preventDefault()
    @model.destroy()
    @remove()

  rename_room: (e) ->
    @delayed_update_room(e) if e
    $button = @$('.save-form .name')
    $value = @$('.room-name-input').val()
    if $value == ""
      $button.text(@placeholder)
    else
      $button.text($value)

  open: ->
    @$('.toggle-room').hasClass('open')

  toggleRoom: (e) ->
    $target = $(e.target)
    @delegate.trigger("showCategory")
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

  done_with_room: (e) ->
    e.preventDefault()
    $target = $(e.target)
    @close_drawer()
    @delegate.trigger("roomComplete")
    @$('.completion-indicator > .glyphicon').addClass('glyphicon-ok')

  category_order: [
    "beds"
    "sofas"
    "chairs"
    "tables"
    "lighting"
    "storage"
    "electronics"
    "music"
    "appliances"
    "other"
  ]

  render_categories: ->
    $target = @$('.category-container')
    @views = {}
    category_order = _.uniq(_.union(_.keys(@model.get('contents')), @category_order))
    _.each category_order, (title) =>
      @views[title] = view = new Mule.Views.Category
        title: title
        room: @model
        delegate: @delegate
      $target.append view.$el