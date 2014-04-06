describe "Submission", ->
  it "A submission can be created with default values for its attributes", ->
    submission = new Mule.Models.Submission()
    expect(submission.get('text')).toBe("Sample")

  xit "triggers an invalid event on failed validation", ->
    errorCallback = jasmine.createSpy('-invalid callback event-')
    submission = new Mule.Models.Submission()
    submission.on('invalid', errorCallback)

    submission.set({done:'non-boolean'})

    errorArgs = errorCallback.mostRecentCall.args

    expect(errorArgs).toBeDefined()
    expect(errorArgs[0]).toBe(submission)
    expect(errorArgs[1]).toBe('Submission.done must be a boolean')