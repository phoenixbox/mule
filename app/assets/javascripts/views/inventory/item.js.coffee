class Mule.Views.Item extends Backbone.View

  template: JST['inventory/item']

  events:
    'click .table-image': '_alert'

  tagName: 'td'

  className: 'item-cell'

  initialize: (options) ->
    @name = options.name
    @app        = options.app
    @router     = @app.router
    @render()

  render: ->
    @$el.html(@template(name: @name, viewContext: @));
    @

  _titleCase: (string) ->
    string.charAt(0).toUpperCase() + string.slice(1);