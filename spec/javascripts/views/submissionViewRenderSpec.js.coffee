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
      expect(@view.render()).toEqual(@view.el)

    it 'produces the correct markup structure and content', ->
      @view.render()
      expect(@view.el).toContainElement('label.submission-content')
      expect(@view.el.innerHTML).toEqual('<label class="submission-content">Submission Content</label>')