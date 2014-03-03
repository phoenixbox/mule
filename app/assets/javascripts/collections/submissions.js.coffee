class Mule.Collections.Submissions extends Backbone.Collection
  url: '/submissions/'
  model: Mule.Models.Submission

  done: ->
    @filter (submission) -> submission.get('done')

  remaining: ->
    @without.apply(@, @.done())