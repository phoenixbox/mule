CategoryActions =
  get: (type) ->
    CategoryOptions[type]

CategoryOptions =
  sofas:
    column_width: 6
    splice: 3
    items: [
      {type: "two seat", count: 0}
      {type: "three seat", count: 0}
      {type: "four seat", count: 0}
      {type: "futon", count: 0}
      {type: "sectional", count: 0}
    ]
  chairs:
    column_width: 6,
    splice: 3
    items: [
      {type: "chair", count: 0}
      {type: "stool", count: 0}
      {type: "office", count: 0}
      {type: "lounge", count: 0}
      {type: "folding", count: 0}
      {type: "bean bag", count: 0}
      {type: "bench", count: 0}
      ],
  electronics:
    column_width: 6
    splice: 3
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
      {type: "fridge", count: 0}
      {type: "freezer", count: 0}
      {type: "oven", count: 0}
      {type: "air conditioner", count: 0}
      {type: "dryer", count: 0}
      {type: "washer", count: 0}
      ],
  beds:
    column_width: 6
    splice: 2
    items: [
      {
        type: "king",
        options: [
          "frame",
          "box spring",
          "mattress"
        ]
      }
      {
        type: "queen",
        options: [
          "frame",
          "box spring",
          "mattress"
        ]
      }
      {
        type: "single",
        options: [
          "frame",
          "box spring",
          "mattress"
        ]
      }
      {
        type: "toddler",
        options: [
          "frame",
          "box spring",
          "mattress"
        ]
      }
    ]
  tables:
    column_width: 6
    splice: 1
    items: [
      {
        type: "general",
        options: [
          "coffee",
          "side",
          "office"
        ]
      }
      {
        type: "dining",
        options: [
          "two seat",
          "four seat",
          "six seat",
          "eight seat"
        ]
      }
    ]
  lighting:
    column_width: 6
    splice: 1
    items:[
      {
        type: "general",
        options: [
          "ceiling fixture",
          "chandelier"
        ]
      }
      {
        type: "lamps",
        options: [
          "floor",
          "desk"
        ]
      }
    ]
  storage:
    column_width: 6
    splice: 2
    items:[
      {
        type: "wardrobes",
        options: [
          "dresser",
          "freestanding"
        ]
      }
      {
        type: "cabinets",
        options: [
          "china",
          "filing",
          "entertainment center"
        ]
      }
      {
        type: "miscellaneous",
        options: [
          "bookcase",
          "storage bin",
          "suitcase",
          "dufflebag",
          "trunk"
        ]
      }
    ]
  music:
    column_width: 6
    splice: 1
    items:[
      {
        type: "general",
        options: [
          "drums",
          "instrument"
        ]
      }
      {
        type: "pianos",
        options: [
          "grand",
          "baby",
          "upright"
        ]
      }
    ]
  other:
    column_width: 6
    splice: 2
    items:[
      {
        type: "miscellaneous",
        options: [
          "mirror",
          "picture",
          "rugs",
          "stroller",
          "car seat",
          "plants",
          "grill"
        ]
      }
      {
        type: "sports",
        options: [
          "skis",
          "snowboard",
          "bicycle",
          "golf clubs",
          "pool table",
          "ping pong"
        ]
      }
      {
        type: "kids",
        options: [
          "play house",
          "play pen",
          "dollhouse"
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
