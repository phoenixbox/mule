class Mule.Models.Submission extends Backbone.Model
  defaults: {
    text: "Sample",
    done: false
  },

  validate: (attributes) ->
    debugger
    if attributes.hasOwnProperty('done') && !_.isBoolean(attributes.done)
      debugger
      'Submission.done must be a boolean'