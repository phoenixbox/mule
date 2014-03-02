describe "Submission", ->
  it "A submission can be created with default values for its attributes", ->
    submission = new Mule.Models.Submission()
    expect(submission.get('text')).toBe("Sample")