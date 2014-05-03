class Mule.Views.Item extends Backbone.View
  events:
    'click .increment-subitem': 'incrementSubItem'
    'click .decrement-subitem': 'decrementSubItem'
    'click .increment-item': 'incrementItem'
    'click .decrement-item': 'decrementItem'

  item_form_segment: JST['inventory/_item_form_segment']
  sub_item_form_segment: JST['inventory/_sub_item_form_segment']

  initialize: (args) ->
    @template = if args.options then @sub_item_form_segment else @item_form_segment
    _.extend(@, _.pick(args, 'item', 'options', 'room', 'category'))
    @room.items ||= {}
    @room.items[@item] = @item
    @render()

  render: ->
    @$el.html(@template(item: @item, options: @options))
    @undelegateEvents()
    @delegateEvents()
    @

  decrementSubItem: (e) ->
    @updateCounters(e, 'decrement', 'subitem')

  incrementSubItem: (e) ->
    @updateCounters(e, 'increment', 'subitem')

  decrementItem: (e) ->
    @updateCounters(e, 'decrement', 'item')

  incrementItem: (e) ->
    @updateCounters(e, 'increment', 'item')

  updateCounters: (e, direction, type) ->
    e.preventDefault()
    $target = $(e.currentTarget)
    $data = $target.data().subitem
    $obj = @$(".counter[data-#{type}='#{$data}']")
    @[direction]($obj, type, $data)

  increment: (obj, type, subitem) ->
    count = parseInt(obj.text()) + 1
    obj.text(count)
    @update_room(count, subitem)

  decrement: (obj, type, subitem) ->
    count = parseInt(obj.text()) - 1
    obj.text(count)
    @update_room(count, subitem)

  update_room: (count, subitem) ->
    opts = {}
    opts[@category.title] = {}
    opts[@category.title].items ||= []
    if subitem
      item = {}
      item[@item] = {subitem: subitem, count: count}
      opts[@category.title].items.push(item)
    else
      opts[@category.title].items.push({item: @item, count: count})
    @room.persist {contents: opts}
