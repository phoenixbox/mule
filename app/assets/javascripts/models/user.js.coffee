class Mule.Models.User extends Backbone.Model
  url: 'users'

  initialize: (options) ->
    @deferred = @fetch()
    @rooms = new Mule.Collections.Rooms()

  defaults:
    email: "tempuser@mule.com"

  parse: (resp) ->
    @rooms.add(resp.rooms)
    delete resp.rooms
    resp
