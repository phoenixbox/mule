class Mule.Models.Category extends Backbone.Model
  initialize: (attrs, options) ->
    options = _.pick options, "title", "room"
    _.extend @, options
    defaults = Mule.Category.Actions.get(@title)
    @set(defaults)
