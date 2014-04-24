class Mule.Models.Room extends Backbone.Model
  defaults:
    name: ""
    type: ""
    beds: 0
    tables: 0
    chairs: 0
    electronics: 0
    accessories: 0

  initialize: (args) ->
    @persist = _.debounce(@_delayed_persist, 1000)
    @on 'change',  =>
      @persist()
      @update_contents()

  update_contents: =>
    debugger
    newContents = _.extend({}, _.pick(@attributes, 'contents'))
    newContents.contents ||= {}
    _.extend(newContents.contents, @changed)
    @set newContents, silent: true

  _delayed_persist: =>
    if @view
      @user = @view.app.user
      @save _.extend({}, @user.key(), _.pick(@attributes, 'contents')),
        patch: true

  parse: (resp) ->
    resp
