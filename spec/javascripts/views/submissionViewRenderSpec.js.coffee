describe 'Submission View Rendering', ->
  beforeEach ->
    @model = new Mule.Models.Submission({
      text: 'Submission Content',
      order: 1,
      done: false
      })
    @view = new Mule.Views.SubmissionsIndex({model: @model})

  describe 'Rendering', ->
    it 'returns the view object', ->
      expect(@view.render()).toEqual(@view)

    it 'produces the correct markup', ->
      @view.render()
      expect(@view.el.innerHTML).toContain('<label class="submission-content">Submission Content</label>')