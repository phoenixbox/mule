class Mule.Views.SubmissionsIndex extends Backbone.View

  template: JST['submissions/index']

  tagName: 'li'

  className: 'submissions'

  render: ->
    @$el.html(@template(submission: @model));