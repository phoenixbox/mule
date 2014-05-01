class Mule.Models.Room extends Backbone.Model
  defaults:
    name: ""
    style: ""
    beds: 0
    tables: 0
    chairs: 0
    electronics: 0
    accessories: 0

  initialize: (args) ->
    @persist = _.debounce(@_delayed_persist, 3000)

  _delayed_persist: (params) =>
    @save(params, silent: true)

  parse: (resp) ->
    resp


  categoryOptions:
    sofas: ["two seat","three seat","four seat","futon","sectional"],
    chairs: ["chair","stool","office","lounge","folding","bean bag","bench"],
    electronics: ["tv","stereo","speakers","computer","printer"],
    appliances: ["fridge","freezer","oven","air conditioner","dryer","washer"],
    beds: [
      {"king": ["frame","box spring","mattress"]},
      {"queen": ["frame","box spring","mattress"]},
      {"single": ["frame","box spring","mattress"]},
      {"toddler": ["frame","box spring","mattress"]}
      ],
    tables: [
      {"general": ["coffee","side","office"]},
      {"dining": ["two seat","four seat","six seat","eight seat"]}
      ],
    lighting: [
      {"general": ["ceiling fixture","chandelier"]},
      {"lamps": ["floor","desk"]}
      ],
    storage: [
      {"wardrobes": ["dresser","freestanding"]},
      {"cabinets": ["china","filing","entertainment center"]},
      {"miscellaneous": ["bookcase","storage bin","suitcase","dufflebag","trunk"]}
      ],
    music: [
      {"general": ["drums","instrument"]},
      {"pianos": ["grand","baby","upright"]}
      ],
    other: [
      {"miscellaneous": ["mirror","picture","rugs","stroller","car seat","plants","grill"]},
      {"sports": ["skis","snowboard","bicycle","golf clubs","pool table","ping pong"]}
      {"kids": ["play house","play pen","dollhouse"]},
      ]
