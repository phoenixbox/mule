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
    @persist = _.debounce(@_delayed_persist, 1000)

  _delayed_persist: (params) =>
    @save(params, slient: true)

  parse: (resp) ->
    resp
