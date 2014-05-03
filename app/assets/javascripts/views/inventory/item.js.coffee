class Mule.Views.Item extends Backbone.View
  events:
    'click .decrement': 'decrementCounter'
    'click .increment': 'incrementCounter'

  item_form_segment: JST['inventory/_item_form_segment']
  sub_item_form_segment: JST['inventory/_sub_item_form_segment']

  initialize: (args) ->
    @template = if args.options then @sub_item_form_segment else @item_form_segment
    _.extend(@, _.pick(args, 'item', 'options'))
    @render()

  render: ->
    @$el.html(@template(item: @item, options: @options))
    @

  decrementCounter: (e) ->
    @updateCounters(e, 'decrement')

  incrementCounter: (e) ->
    @updateCounters(e, 'increment')

  updateCounters: (e, direction) ->
    e.preventDefault()
    $target = $(e.currentTarget)

    $item = @$("[data-subitem]")
    $item = @$("[data-item]")
    debugger

  # update_room: (e) ->
  #   $target = $(e.currentTarget)
  #   attr = $target.attr('name')
  #   value = @_get_value($target)
  #   @model.set(attr, value)
  #   @model.persist()
  #
  # _get_value: (element) ->
  #   element.val() if element.is('input')
