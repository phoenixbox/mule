class Mule.Views.Room extends Backbone.View

  template: JST['inventory/room']

  className: 'room room-inventory'

  placeholder: 'Done with room'
  roomFurnitureCount: 0

  events:
    'click .toggle-room': 'toggleRoom'
    'keyup .room-name-input': 'rename_room'
    'click .toggle-category': '_toggleCategory'
    'click .save-form': '_saveRoom'
    'click .save-category': '_doneWithCategory'
    'click .decrement': '_updateCounters'
    'click .increment': '_updateCounters'
    'click .remove-room': 'removeRoom'

  initialize: (options) ->
    @app        = options.app
    @delegate   = options.delegate
    @router     = @app.router
    @user       = @app.user
    @delayed_update_room = _.debounce(@update_room, 1000)
    @render()

  render: ->
    @$el.html(@template(model: @model, categories: @_categoryOptions(), view: @))
    @rename_room()
    @roomFurnitureCounter = @.$el.find('.furniture-for-room')
    @

  _items: (collection) ->
    _.first(_.values(collection))

  _title: (collection) ->
    _.keys(collection)

  _get_value: (element) ->
    element.val() if element.is('input')

  update_room: (e) ->
    $target = $(e.currentTarget)
    attr = $target.attr('name')
    value = @_get_value($target)
    @model.set(attr, value)
    @model.persist()

  removeRoom: (e) ->
    e.preventDefault()
    @model.destroy
      error: =>
        window.location.href = '/inventory'
      success: =>
        @remove()

  rename_room: (e) ->
    @delayed_update_room(e) if e
    $button = @$('.save-form')
    $value = $('.room-name-input').val()
    if $value == ""
      $button.text(@placeholder)
    else
      oldName = $button.text().split(" ").splice(0,2)
      newName = oldName.concat($value).join(" ")
      $button.text(newName)

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

  open: ->
    @$('.toggle-room').hasClass('open')

  toggleRoom: (e) ->
    $target = $(e.target)
    if @open() then @close_drawer() else @open_drawer()
    @_scrollToTargetPosition($(e.target).position().top)

  open_drawer: (e) =>
    @$('.toggle-room').addClass('open')
    @$('.contents-form').addClass('open')

  close_drawer: (e) ->
    @$('.toggle-room').removeClass('open')
    @$('.contents-form').removeClass('open')

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
    e.preventDefault()
    $target = $(e.target)
    @close_drawer()
    @$('.completion-indicator > .glyphicon').addClass('glyphicon-ok')

  _findRoomDrawer: ->
    @$('.contents-form')

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
