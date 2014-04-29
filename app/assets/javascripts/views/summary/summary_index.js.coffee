class Mule.Views.SummaryIndex extends Backbone.View

  template: JST['summary/index']

  className: 'summary'

  initialize: (options) ->
    @app        = options.app
    @router     = @app.router
    @user       = @app.user
    @rooms      = @user.rooms
    debugger
    @render()
    @listenTo(@user, 'change', @render)

  render: ->
    @$el.html(@template(user: @user, rooms: @rooms))
    @

  rooms: -> [
  	{
  	    "name": "Master Bedroom",
  	    "beds": [
  	        {
  	            "type": "king",
  	            "frames": 2,
  	            "matresses": 1,
  	            "box_springs": 2
  	        },
  	        {
  	            "type": "toddler",
  	            "frames": 1,
  	            "matresses": 1,
  	            "box_springs": 0
  	        }
  	    ]
  	}
  ]
