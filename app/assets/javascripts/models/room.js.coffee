class Mule.Models.Room extends Backbone.Model
  defaults:
    name: ""
    style: ""
    beds: 0
    tables: 0
    chairs: 0
    electronics: 0
    accessories: 0

  url: ->
    "/rooms/#{@id}"

  initialize: (args) ->
    @persist = _.debounce(@_delayed_persist, 3000)

  _delayed_persist: (params) =>
    @save(params, silent: true)

  parse: (resp) ->
    resp
