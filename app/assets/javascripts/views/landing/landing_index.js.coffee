class Mule.Views.LandingIndex extends Backbone.View

  template: JST['landing/start_inventory_form']

  # events:
    # 'click #startInventory': 'startInventory'

  className: 'rooms'

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router

  render: ->
    @$el.html(@template(room: @model));
    @

  # startInventory: (e) ->
  #   debugger
  #   e.preventDefault()
  #   email = $('#new_user_email').val()
  #   room_number = @.$el.find('.room-numbers').find(":selected").text()
  #   @user = new Mule.Models.User(email: email, rooms: room_number)
  #   @app.user = @user
  #   @user.save null,
  #     success:(data) =>
  #       window.location.href = "/inventory"
  #       @$el.parents().children().find('.modal-backdrop').remove()
  #       @$el.remove()
  #     error:(data) =>
  #       error = JSON.parse(data.responseText).errors[0]
  #       alert("Sorry: " + error)
  #       console.log("Error saving user: " + error)
