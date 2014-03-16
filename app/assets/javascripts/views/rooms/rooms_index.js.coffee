class Mule.Views.RoomsIndex extends Backbone.View

  template: JST['rooms/index']

  # tagName: 'li'

  className: 'rooms'

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    @$el.html(@template(room: @model));
    @