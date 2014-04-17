class Mule.Models.User extends Backbone.Model
  url: 'users'

  initialize: ->
    @deferred = @fetch()

  defaults:
    email: "tempuser@mule.com"
