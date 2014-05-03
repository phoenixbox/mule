class Mule.Models.Category extends Backbone.Model
  initialize: (options) ->
    options = _.pick options, "title", "room"
    _.extend @, options
    @persist = _.debounce(@_delayed_persist, 3000)
    defaults = Mule.Category.Actions.get(@title)
    @set(defaults)

  _delayed_persist: (params) =>
    @save(params, silent: true)
