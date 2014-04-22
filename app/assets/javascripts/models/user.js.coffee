class Mule.Models.User extends Backbone.Model
  url: 'users'

  initialize: (options) ->
    @deferred = @fetch() if options.fetch
    @rooms = new Mule.Collections.Rooms()
    @touch = _.debounce(@_touch, 50)
    @listenTo(@rooms, 'change add', @touch)

  defaults:
    email: "tempuser@mule.com"

  key: ->
    {user: {key: @get('email')}}

  parse: (resp) ->
    @rooms.add(resp.rooms)
    delete resp.rooms
    resp

  _touch: =>
    @trigger('change')

  logger: (e) ->
    console.log 'add', e
