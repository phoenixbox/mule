describe "Submissions", ->
  it 'can add submission model instances as objects and arrays', ->
    submissions = new Mule.Collections.Submissions()
    expect(submissions.length).toBe(0)
    # Add object
    submissions.add({text: 'First'})
    # Assert length
    expect(submissions.length).toBe(1)

    submissions.add([
      {text: 'second'},
      {text: 'third'},
      {text: 'fourth'}
    ])

    expect(submissions.length).toBe(4)

  it 'has a URL property for fetching all submission models', ->
    submissions = new Mule.Collections.Submissions()
    # PAIN: Collections property fetching not get
    expect(submissions.url).toBe('/submissions/')

  it 'calculates the remaining and done tasks', ->
    submissions = new Mule.Collections.Submissions()
    submissions.add([
      {title:'completed',done: true},
      {title:'incomplete', done:false},
      {title:'incomplete', done:false}
    ])

    expect(submissions.done().length).toBe(1)
    expect(submissions.remaining().length).toBe(2)