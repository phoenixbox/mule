class Mule.Models.Category extends Backbone.Model
  initialize: (options) ->
    options = _.pick options, "title"
    _.extend @, options
    @persist = _.debounce(@_delayed_persist, 3000)
    defaults = new CategoryOptions().get(@title)
    @set(defaults)

  _delayed_persist: (params) =>
    @save(params, silent: true)

class CategoryOptions
  get: (type) ->
    @[type]

  sofas:
    column_width: 6
    splice: 3
    items: ["two seat","three seat","four seat","futon","sectional"]
  chairs:
    column_width: 6,
    splice: 3
    items: ["chair","stool","office","lounge","folding","bean bag","bench"],
  electronics:
    column_width: 6
    splice: 3
    items: ["tv","stereo","speakers","computer","printer"]
  appliances:
    column_width: 6
    splice: 3
    items: ["fridge","freezer","oven","air conditioner","dryer","washer"],
  beds:
    column_width: 6
    splice: 2
    items:
      "king": ["frame","box spring","mattress"]
      "queen": ["frame","box spring","mattress"]
      "single": ["frame","box spring","mattress"]
      "toddler": ["frame","box spring","mattress"]
  tables:
    column_width: 6
    splice: 1
    items:
      "general": ["coffee","side","office"]
      "dining": ["two seat","four seat","six seat","eight seat"]
  lighting:
    column_width: 6
    splice: 1
    items:
      "general": ["ceiling fixture","chandelier"]
      "lamps": ["floor","desk"]
  storage:
    column_width: 6
    splice: 2
    items:
      "wardrobes": ["dresser","freestanding"]
      "cabinets": ["china","filing","entertainment center"]
      "miscellaneous": ["bookcase","storage bin","suitcase","dufflebag","trunk"]
  music:
    column_width: 6
    splice: 1
    items:
      "general": ["drums","instrument"]
      "pianos": ["grand","baby","upright"]
  other:
    column_width: 6
    splice: 2
    items:
      "miscellaneous": ["mirror","picture","rugs","stroller","car seat","plants","grill"]
      "sports": ["skis","snowboard","bicycle","golf clubs","pool table","ping pong"]
      "kids": ["play house","play pen","dollhouse"]
