class Mule.Views.LandingIndex extends Backbone.View

  template: JST['landing/index']

  events:
    'click #startInventory': '_startInventory'

  className: 'rooms'

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router
    @listenTo(@collection, "reset", @render)

  render: ->
    @$el.html(@template(room: @model));
    @

  _startInventory: (e) ->
    email = @.$el.find('input').val()
    $.ajax({
      type: "POST",
      url: "/users",
      data: { user: { email: email } },
      success:(data) =>
        room_number = @.$el.find('.room-numbers').find(":selected").text()
        window.localStorage.setItem("roomNumber",room_number);
        window.localStorage.setItem("email",data.email);
        @$el.parents().children().find('.modal-backdrop').remove()
        @$el.remove()
        @router.navigate("inventory", trigger: true)
      error:(data) =>
        error = JSON.parse(data.responseText).errors[0]
        alert("Sorry: " + error)
        console.log("Error saving user: " + error)
    })
