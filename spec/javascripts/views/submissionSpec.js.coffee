describe 'submission view', ->
  beforeEach ->
    $('body').append('<ul id="submissionList"></ul>')
    @submissionView = new Mule.Views.SubmissionsIndex({model: new Mule.Models.Submission()})

  afterEach ->
    @submissionView.remove()
    $('#submissionList').remove()

  it 'should be tied to the DOM element when created based off the property provided', ->
    expect(@submissionView.el.tagName.toLowerCase()).toBe('li')