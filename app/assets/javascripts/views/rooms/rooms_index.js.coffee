class Mule.Views.RoomsIndex extends Backbone.View

  template: JST['rooms/index']

  # tagName: 'li'
  events:
    'click #startInventory': '_startInventory'

  className: 'rooms'

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    @$el.html(@template(room: @model));
    @

  _startInventory: (e) ->
    email = $('input').val()
    if email.length > 0
      alert(email)
    else
      alert("You must enter an email")