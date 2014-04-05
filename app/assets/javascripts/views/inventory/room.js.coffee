class Mule.Views.Room extends Backbone.View

  template: JST['inventory/room']

  className: 'room'

  events:
    'click .toggle': '_toggleRoom'
    'click .save-form': '_saveRoom'
    'click .decrement': '_updateCounters'
    'click .increment': '_updateCounters'
    'click .glyphicon-pencil': '_toggleEditable'
    'click .glyphicon-remove': '_toggleCompletedState'
    'click .glyphicon-ok': '_toggleCompletedState'

  initialize: (options) ->
    @app        = options.app
    @delegate   = options.delegate
    @router     = @app.router
    @totalFurnitureCount = 0

  render: ->
    @$el.html(@template(categories: @_categoryOptions()));
    @totalFurnitureCounter = @.$el.find('.furniture-for-room')
    @

  _categoryOptions: ->
    {
      "sofas": ["2 seat", "3 seat", "4 seat", "futon", "sectional"],
      "chairs": ["chair", "stool", "office", "lounge", "folding", "bean bag", "bench"],
      "tables": [ {"dining": ["2 seat","4 seat","6 seat","8 seat"]},
                  "coffee", "side", "office"
              ],
      "lamps": ["floor", "table"],
      "storage": [ {"wardrobes": ["dresser","freestanding"]},
                    "bookcase",
                    {"cabinets": ["china","filing","entertainment center"]},
                    {"misc": ["storage bin","suitcase","dufflebag","trunk"]},
                ],
      "electronics": ["tv", "stereo", "speakers", "computer", "printer"],
      "music": [  {"pianos": ["grand","baby","upright"]},
                  "drums",
                  "instrument"
              ],
      "appliances": ["air conditioner","dryer","washer"],
      "other":  ["mirror","picture","rugs","chandelier","stroller","car seat","plants","grill",
                {"kids": ["play house","play pen","dollhouse"]},
                {"sports": ["skis","snowboard","bicycle","golf clubs","pool table", "ping pong"]}
              ]
    }

  _toggleEditable: (e) ->
    @delegate.trigger("nameRoom")
    e.preventDefault()
    $target = $(e.target)
    $input = $target.parents('.name').children('.room-name-input')

    $input.keydown (e) =>
      if e.keyCode == 13
        $input.attr('readonly', true)

    if $input.prop('readonly')
      $input.attr('readonly', false)
      $input.focus()

    $input.blur =>
      $input.attr('readonly', true)

  _updateCounters: (e) ->
    $target = $(e.target)
    $itemCounter = $target.parents('.quantity').children('.counter')
    $itemCounterValue = parseInt($itemCounter.text())

    if $target.is('.decrement')
      $itemCounterValue -= 1
      @totalFurnitureCount -= 1
    else
      @delegate.trigger("explainFurnitureCount")
      $itemCounterValue += 1
      @totalFurnitureCount += 1

    $itemCounter.text($itemCounterValue).toString()
    @totalFurnitureCounter.text(@totalFurnitureCount.toString())

  _toggleRoom: (e) ->
    @delegate.trigger("incrementItemCount")
    $target = $(e.target)
    $roomDrawer = @_findDrawer($target)
    @_toggleDrawer($roomDrawer, $target)

  _saveRoom: (e) ->
    e.preventDefault()
    $target = $(e.target)
    $roomDrawer = @_findDrawer($target)

    $icon = $target.parents('.room-inventory').find('.glyphicon-remove')
    $icon.addClass('glyphicon-ok').removeClass('glyphicon-remove')

    $chevron = $target.parents('.room-inventory').find('.glyphicon-chevron-down')

    @_toggleDrawer($roomDrawer, $chevron)

  _toggleCompletedState: (e) ->
    e.preventDefault()
    $target = $(e.target)
    @_addOrReplaceTick($target)

  _addOrReplaceTick: (target) ->
    $icon = target.parents('.room-inventory').find('.glyphicon-remove')
    if $icon.length > 0
      $icon.addClass('glyphicon-ok').removeClass('glyphicon-remove')
    else
      $icon = target.parents('.room-inventory').find('.glyphicon-ok')
      $icon.addClass('glyphicon-remove').removeClass('glyphicon-ok')

  _findDrawer: (target) ->
    target.parents('.room-inventory').children('.contents-form')

  _toggleDrawer: (drawer, target) ->
    drawer.slideToggle
      duration: 0
      complete: ->
        if drawer.is(':visible')
          target.addClass('glyphicon-chevron-down').removeClass('glyphicon-chevron-right')
        else
          target.addClass('glyphicon-chevron-right').removeClass('glyphicon-chevron-down')