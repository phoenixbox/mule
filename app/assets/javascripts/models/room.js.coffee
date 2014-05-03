class Mule.Models.Room extends Backbone.Model
  initialize: (args) ->
    @persist = _.debounce(@_delayed_persist, 500)

  _delayed_persist: (params) =>
    @save(params, silent: true)

  parse: (resp) ->
    resp
