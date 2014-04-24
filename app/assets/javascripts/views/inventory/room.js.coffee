class Mule.Views.Room extends Backbone.View

  template: JST['inventory/room']

  className: 'room'

  events:
    'click .toggle-room': '_toggleRoom'
    'click .toggle-category': '_toggleCategory'
    'click .save-form': '_saveRoom'
    'click .save-category': '_doneWithCategory'
    'click .decrement': '_updateCounters'
    'click .increment': '_updateCounters'
    'click .glyphicon-pencil': '_toggleEditable'
    'click .glyphicon-remove': '_toggleCompletedState'
    'click .room-name-input': '_changeSaveName'
    'click .remove-room': 'removeRoom'

  initialize: (options) ->
    @app        = options.app
    @delegate   = options.delegate
    @router     = @app.router
    @user       = @app.user
    @updateRoom = _.throttle(@_update_room, 1000)
    @roomFurnitureCount = 0
    @placeholder = "Done with room"

  render: ->
    @$el.html(@template(model: @model, categories: @_categoryOptions(), view: @))
    @roomFurnitureCounter = @.$el.find('.furniture-for-room')
    @

  _items: (collection) ->
    _.first(_.values(collection))

  _title: (collection) ->
    _.keys(collection)

  updateRoom: (e) ->
    debugger

  removeRoom: (e) ->
    e.preventDefault()
    @model.destroy
      data: JSON.stringify(@user.key)
      contentType: 'application/json'
    @remove()

  _changeSaveName: (e) ->
    e.preventDefault()
    $target = $(e.target)
    $saveButton = $target.parents('.room-inventory').find('.save-form')

    $target.keydown (e) =>
      if e.keyCode == 13
        @_renameRoom()

    $target.blur =>
      @_renameRoom()

  _renameRoom: ->
    $button = @.$el.find('.save-form')
    $input = @.$el.find('.room-name-input')
    if $input.val() == ""
      $button.text(@placeholder)
    else
      roomName = $input.val().split(" ")
      oldName = $button.text().split(" ").splice(0,2)
      newName = oldName.concat(roomName).join(" ")
      $button.text(newName)

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
      if $itemCounterValue > 0
        $itemCounterValue -=1
        if $categoryCounterValue > 0 then $categoryCounterValue -=1
        if @roomFurnitureCount > 0 then @roomFurnitureCount -=1
        @delegate._incrementTotal(-1)
    else
      @delegate.trigger("explainFurnitureCount")
      $itemCounterValue += 1
      $categoryCounterValue +=1
      @roomFurnitureCount +=1
      @delegate._incrementTotal(+1)

    $itemCounter.text($itemCounterValue.toString())
    $categoryCounter.text($categoryCounterValue.toString())
    @roomFurnitureCounter.text(@roomFurnitureCount.toString())

  _toggleRoom: (e) ->
    @delegate.trigger("showCategory")
    $target = $(e.target)
    $roomDrawer = @_findRoomDrawer($target)
    @_toggleDrawer($roomDrawer, $target)

    targetScrollPosition = $target.position().top
    @_scrollToTargetPosition(targetScrollPosition)

  _toggleCategory: (e) ->
    e.preventDefault()
    @delegate.trigger("incrementItemCount")
    $target = $(e.target)
    $categoryDrawer = $target.parents('.category-container').children('.category-dropdown')
    @_toggleDrawer($categoryDrawer, $target)

    targetScrollPosition = $target.parents('.row').position().top + $target.position().top
    @_scrollToTargetPosition(targetScrollPosition)

  _doneWithCategory: (e) ->
    e.preventDefault()
    $target = $(e.target)
    $chevron = $target.parents('.category-container').find('.glyphicon-chevron-down')
    $chevron.click()

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
            "two seat",
            "three seat",
            "four seat",
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
                "general": [
                    "coffee",
                    "side",
                    "office"
                ]
            },
            {
                "dining": [
                    "two seat",
                    "four seat",
                    "six seat",
                    "eight seat"
                ]
            }
        ],
        "lighting": [
            {
                "general": [
                    "ceiling fixture",
                    "chandelier"
                ]
            },
            {
                "lamps": [
                    "floor",
                    "desk"
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
            {
                "general": [
                    "drums",
                    "instrument"
                ]
            },
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
