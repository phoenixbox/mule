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
    @merge_defaults()
    @render()

  merge_defaults: ->
    cat_defaults = @room.get('contents')[@category.title]
    if cat_defaults
      items = cat_defaults.items
      item = _.findWhere(items, {type: @item.type})
      @item = item if item

  render: ->
    @$el.html(@template(item: @item))
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

  increment: (counter_el, type, target_item) ->
    count = parseInt(counter_el.text()) + 1
    counter_el.text(count)
    @update_room(count, target_item)

  decrement: (counter_el, type, target_item) ->
    count = parseInt(counter_el.text()) - 1
    count = 0 if count < 1
    counter_el.text(count)
    @update_room(count, target_item)

  update_room: (count, type) ->
    opts = {}
    opts[@category.title] = {}
    opts[@category.title].items ||= []
    category_items = _.findWhere(@category.model.get('items'), {type: @item.type})
    category_index = _.indexOf(@category.model.get('items'), category_items)
    if @item.options
      item = _.findWhere(category_items.options, {type: type})
      item_index = _.indexOf(category_items.options, item)
      item.count = count
      category_items.options[item_index] = item
      opts[@category.title].items.push category_items
    else
      item = category_items
      item.count = count
      opts[@category.title].items.push item
    @room.persist {contents: opts}
