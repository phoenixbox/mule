class Mule.Routers extends Backbone.Router
  routes:
    '':'index'
    'inventory': 'inventory'
    'summary': 'summary'

  initialize: (options)->
    @app = options.app
    @app.router = this
    
  index: ->
    @view?.remove()
    @view = new Mule.Views.LandingIndex(app: @app)
    $('#wrapper').html(@view.render().el)

  inventory: ->
    @view?.remove()
    @view = new Mule.Views.InventoryIndex(app: @app)
    $('#wrapper').html(@view.el)

  summary: ->
    @view?.remove()
    @view = new Mule.Views.SummaryIndex(app: @app)
    $('#wrapper').html(@view.el)
