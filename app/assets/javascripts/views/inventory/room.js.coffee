class Mule.Views.Room extends Backbone.View

  template: JST['inventory/room']

  className: 'room'

  events:
    'click .toggle-room': '_toggleRoom'
    'click .toggle-category': '_toggleCategory'
    'click .save-form': '_saveRoom'
    'click .decrement': '_updateCounters'
    'click .increment': '_updateCounters'
    'click .glyphicon-pencil': '_toggleEditable'
    'click .glyphicon-remove': '_toggleCompletedState'

  initialize: (options) ->
    @app        = options.app
    @delegate   = options.delegate
    @router     = @app.router
    @totalFurnitureCount = 0

  render: ->
    @$el.html(@template(categories: @_categoryOptions(), view: @));
    @totalFurnitureCounter = @.$el.find('.furniture-for-room')
    @

  _items: (collection) ->
    _.first(_.values(collection))

  _title: (collection) ->
    _.keys(collection)

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

    $categoryCounter = $target.parents('.category-container').children('.category-header').find('.counter')
    $categoryCounterValue = parseInt($categoryCounter.text())

    if $target.is('.decrement')
      $itemCounterValue -= 1
      @totalFurnitureCount -= 1
      $categoryCounterValue -=1
    else
      @delegate.trigger("explainFurnitureCount")
      $itemCounterValue += 1
      @totalFurnitureCount += 1
      $categoryCounterValue +=1

    $itemCounter.text($itemCounterValue).toString()
    $categoryCounter.text($categoryCounterValue).toString()
    @totalFurnitureCounter.text(@totalFurnitureCount.toString())

  _toggleRoom: (e) ->
    @delegate.trigger("showCategory")
    $target = $(e.target)
    $roomDrawer = @_findRoomDrawer($target)
    @_toggleDrawer($roomDrawer, $target)

    targetScrollPosition = $target.position().top
    @_scrollToTargetPosition(targetScrollPosition)


  _toggleCategory: (e) ->
    @delegate.trigger("incrementItemCount")
    $target = $(e.target)
    $categoryDrawer = $target.parents('.category-container').children('.category-dropdown')
    @_toggleDrawer($categoryDrawer, $target)

    targetScrollPosition = $target.parents('.row').position().top + $target.position().top
    @_scrollToTargetPosition(targetScrollPosition)

  _scrollToTargetPosition: (targetPosition) ->
    $('body').animate({scrollTop:targetPosition}, 600);

  _saveRoom: (e) ->
    @delegate.trigger("roomComplete")
    e.preventDefault()
    $target = $(e.target)
    $roomDrawer = @_findRoomDrawer($target)
    $icon = $target.parents('.room-inventory').find('.completion-indicator').children()
    $icon.addClass('glyphicon-ok')

    $chevron = $target.parents('.room-inventory').find('.glyphicon-chevron-down')

    @_toggleDrawer($roomDrawer, $chevron)

  _findRoomDrawer: (target) ->
    target.parents('.room-inventory').children('.contents-form')

  _toggleDrawer: (drawer, target) ->
    drawer.slideToggle
      duration: 200
      complete: ->
        if drawer.is(':visible')
          target.addClass('glyphicon-chevron-down').removeClass('glyphicon-chevron-right')
        else
          target.addClass('glyphicon-chevron-right').removeClass('glyphicon-chevron-down')

  _categoryOptions: ->
    {
        "beds": [
          {
              "king": [
                  "frame",
                  "box spring",
                  "mattress"
              ]
          },
          {
              "queen": [
                  "frame",
                  "box spring",
                  "mattress"
              ]
          },
          {
              "single": [
                  "frame",
                  "box spring",
                  "mattress"
              ]
          },
          {
              "toddler": [
                  "frame",
                  "box spring",
                  "mattress"
              ]
          }
        ],
        "sofas": [
            "2 seat",
            "3 seat",
            "+4 seat",
            "futon",
            "sectional"
        ],
        "chairs": [
            "chair",
            "stool",
            "office",
            "lounge",
            "folding",
            "bean bag",
            "bench"
        ],
        "tables": [
            {
                "dining": [
                    "2 seat",
                    "4 seat",
                    "6 seat",
                    "+8 seat"
                ]
            },
            "coffee",
            "side",
            "office"
        ],
        "lighting": [
            "ceiling fixture",
            "chandelier",
            {
                "lamps": [
                    "floor",
                    "table"
                ]
            }
        ],
        "storage": [
            {
                "wardrobes": [
                    "dresser",
                    "freestanding"
                ]
            },
            {
                "cabinets": [
                    "china",
                    "filing",
                    "entertainment center"
                ]
            },
            {
                "miscellaneous": [
                    "bookcase",
                    "storage bin",
                    "suitcase",
                    "dufflebag",
                    "trunk"
                ]
            }
        ],
        "electronics": [
            "tv",
            "stereo",
            "speakers",
            "computer",
            "printer"
        ],
        "music": [
            "drums",
            "instrument",
            {
                "pianos": [
                    "grand",
                    "baby",
                    "upright"
                ]
            }
        ],
        "appliances": [
            "fridge",
            "freezer",
            "oven",
            "air conditioner",
            "dryer",
            "washer"
        ],
        "other": [
            {
                "miscellaneous": [
                    "mirror",
                    "picture",
                    "rugs",
                    "stroller",
                    "car seat",
                    "plants",
                    "grill"
                ]
            },
            {
                "kids": [
                    "play house",
                    "play pen",
                    "dollhouse"
                ]
            },
            {
                "sports": [
                    "skis",
                    "snowboard",
                    "bicycle",
                    "golf clubs",
                    "pool table",
                    "ping pong"
                ]
            }
        ]
    }