class Mule.Models.User extends Backbone.Model
  url: 'users'

  initialize: (options) ->
    @deferred = @fetch()
    @rooms = new Mule.Collections.Rooms()

  defaults:
    email: "tempuser@mule.com"

  key: ->
    {user: {key: @get('email')}}

  parse: (resp) ->
    _.each resp.rooms, (room) ->
      _.extend room, room.contents
    @rooms.add(resp.rooms)
    delete resp.rooms
    resp
