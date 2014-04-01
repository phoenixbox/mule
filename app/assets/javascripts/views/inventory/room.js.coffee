class Mule.Views.Room extends Backbone.View

  template: JST['inventory/room']

  className: 'room'

  events:
    'click .toggle': '_toggleRoom'
    'click .save-form': '_saveRoom'
    'click .decrement': '_updateCounter'
    'click .increment': '_updateCounter'

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router

  render: ->
    @$el.html(@template(categories: @_categoryOptions()));
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

  _updateCounter: (e) ->
    $target = $(e.target)
    $counter = $target.parents('.quantity').children('.counter')
    $value = parseInt($counter.text())
    if $target.is('.decrement')
      $value -= 1
    else
      $value += 1
    $counter.text($value).toString()

  _toggleRoom: (e) ->
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