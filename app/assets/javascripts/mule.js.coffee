CategoryActions =
  get: (type) ->
    CategoryOptions[type]

CategoryOptions =
  sofas:
    column_width: 6
    splice: 3
    count: 0
    items: [
      {type: "two seat", count: 0}
      {type: "three seat", count: 0}
      {type: "four seat", count: 0}
      {type: "futon", count: 0}
      {type: "sectional", count: 0}
    ]
  chairs:
    column_width: 6
    splice: 3
    count: 0
    items: [
      {type: "chair", count: 0}
      {type: "stool", count: 0}
      {type: "office", count: 0}
      {type: "lounge", count: 0}
      {type: "bean bag", count: 0}
      {type: "bench", count: 0}
      ],
  electronics:
    column_width: 6
    splice: 3
    count: 0
    items: [
      {type: "tv", count: 0}
      {type: "stereo", count: 0}
      {type: "speakers", count: 0}
      {type: "computer", count: 0}
      {type: "printer", count: 0}
      ]
  appliances:
    column_width: 6
    splice: 3
    items: [
      {type: "fridge freezer", count: 0}
      {type: "oven", count: 0}
      {type: "air conditioner", count: 0}
      {type: "dryer", count: 0}
      {type: "washer", count: 0}
      ],
  beds:
    column_width: 6
    splice: 2
    count: 0
    items: [
      {
        type: "king"
        options: [
          {type: "frame", count: 0 }
          {type: "box spring", count: 0 }
          {type: "mattress", count: 0 }
        ]
      }
      {
        type: "queen"
        options: [
          {type: "frame", count: 0 }
          {type: "box spring", count: 0 }
          {type: "mattress", count: 0 }
        ]
      }
      {
        type: "single"
        options: [
          {type: "frame", count: 0 }
          {type: "box spring", count: 0 }
          {type: "mattress", count: 0 }
        ]
      }
      {
        type: "toddler"
        options: [
          {type: "frame", count: 0 }
          {type: "box spring", count: 0 }
          {type: "mattress", count: 0 }
        ]
      }
    ]
  tables:
    column_width: 6
    splice: 1
    count: 0
    items: [
      {
        type: "general"
        options: [
          {type: "coffee", count: 0 }
          {type: "side", count: 0 }
          {type: "office", count: 0 }
        ]
      }
      {
        type: "dining"
        options: [
          {type: "two chairs", count: 0 }
          {type: "four chairs", count: 0 }
          {type: "six chairs", count: 0 }
          {type: "eight chairs", count: 0 }
        ]
      }
    ]
  lighting:
    column_width: 6
    splice: 1
    count: 0
    items:[
      {
        type: "general"
        options: [
          {type: "ceiling fixture", count: 0 }
          {type: "chandelier", count: 0 }
        ]
      }
      {
        type: "lamps"
        options: [
          {type: "floor", count: 0 }
          {type: "desk", count: 0 }
        ]
      }
    ]
  storage:
    column_width: 6
    splice: 2
    count: 0
    items:[
      {
        type: "wardrobes"
        options: [
          {type: "dresser", count: 0 }
          {type: "freestanding", count: 0 }
        ]
      }
      {
        type: "cabinets"
        options: [
          {type: "china", count: 0 }
          {type: "filing", count: 0 }
          {type: "entertainment center", count: 0 }
        ]
      }
      {
        type: "miscellaneous"
        options: [
          {type: "bookcase", count: 0 }
          {type: "storage bin", count: 0 }
          {type: "suitcase", count: 0 }
          {type: "dufflebag", count: 0 }
          {type: "trunk", count: 0 }
        ]
      }
    ]
  music:
    column_width: 6
    splice: 1
    count: 0
    items:[
      {
        type: "general"
        options: [
          {type: "drums", count: 0 }
          {type: "instrument", count: 0 }
        ]
      }
      {
        type: "pianos"
        options: [
          {type: "grand", count: 0 }
          {type: "baby", count: 0 }
          {type: "upright", count: 0 }
        ]
      }
    ]
  other:
    column_width: 6
    splice: 2
    count: 0
    items:[
      {
        type: "miscellaneous"
        options: [
          {type: "mirror", count: 0 }
          {type: "picture", count: 0 }
          {type: "rugs", count: 0 }
          {type: "stroller", count: 0 }
          {type: "car seat", count: 0 }
          {type: "plants", count: 0 }
          {type: "grill", count: 0 }
        ]
      }
      {
        type: "sports"
        options: [
          {type: "skis", count: 0 }
          {type: "snowboard", count: 0 }
          {type: "bicycle", count: 0 }
          {type: "golf clubs", count: 0 }
          {type: "pool table", count: 0 }
          {type: "ping pong", count: 0 }
        ]
      }
      {
        type: "kids"
        options: [
          {type: "toy box", count: 0 }
          {type: "dollhouse", count: 0 }
        ]
      }
    ]

window.Mule =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Category:
    Options: CategoryOptions
    Actions: CategoryActions

  initialize: ->
    @user = new Mule.Models.User()
    @session = new Mule.Models.Session(@user.attributes)
    @router = new Mule.Routers(app: this)
    Backbone.history.start({pushState: true})

window.render_partial = ( path, options = {} ) ->
  path = path.split('/')
  path[ path.length - 1 ] = '_' + path[ path.length - 1 ]
  path = path.join('/')
  try
    JST["#{ path }"]( options )
  catch error
    "<p class='error'>Sorry, there is no partial named '#{ path }'.</p>"

$(document).ready ->
  new FastClick(document.body)
  Mule.initialize(CategoryOptions)
  $("#wrapper").on 'click', (e) =>
    $el = $(e.target)
    mixpanel.track "Inventory page click", {id: $el.attr('id'), class: $el.attr('class'), name: $el.attr('name')}