class Mule.Views.Item extends Backbone.View
  events:
    'click .increment-subitem': 'incrementSubItem'
    'click .decrement-subitem': 'decrementSubItem'
    'click .increment-item': 'incrementItem'
    'click .decrement-item': 'decrementItem'

  item_form_segment: JST['inventory/_item_form_segment']
  sub_item_form_segment: JST['inventory/_sub_item_form_segment']

  initialize: (args) ->
    _.extend(@, _.pick(args, 'item', 'room', 'category'))
    @template = if @item.options then @sub_item_form_segment else @item_form_segment
    @render()

  render: ->
    @$el.html(@template(item: @item))
    # if @room.get('contents')[@category.title]
    #   items = @room.get('contents')[@category.title].items
    # else
    #   debugger
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
    $data = $target.data()[type]
    $counter_el = @$(".counter[data-#{type}='#{$data}']")
    @[direction]($counter_el, type, $data)

  increment: (counter_el, type, subitem) ->
    count = parseInt(counter_el.text()) + 1
    counter_el.text(count)
    @update_room(count, subitem)

  decrement: (counter_el, type, subitem) ->
    count = parseInt(counter_el.text()) - 1
    counter_el.text(count)
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
