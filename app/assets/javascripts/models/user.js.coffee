class Mule.Models.User extends Backbone.Model
  url: 'users'

  initialize: (options) ->
    @deferred = @fetch()
    @rooms = new Mule.Collections.Rooms()
    @touch = _.debounce(@_throttle_touch, 50)
    @listenTo(@rooms, 'change add', @touch)

  defaults:
    email: "tempuser@mule.com"

  key: ->
    {user: {key: @get('email')}}

  parse: (resp) ->
    _.each resp.rooms, (room) ->
      _.extend room, room.contents
      delete room.contents
    @rooms.add(resp.rooms)
    delete resp.rooms
    resp

  _throttle_touch: =>
    @trigger('change')
