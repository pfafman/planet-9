
getSelect = ->
  num = Math.round(Math.random()*3)
  switch "#{num}"
    when '0'
      'zero'
    when '1'
      'one'
    when '2'
      'two'
    when '3'
      'three'

Meteor.startup ->
  console.log("Server Start Up")

  # Populate test data into Mongo
  testCount = 200
  if TestData.find().count() < testCount
    TestData.remove({})
    for i in [0 .. testCount-1]
      main_id = TestData.insert
        title: "Item #{i}"
        value: i
        invert: testCount - i
        comment: "This is a comment for #{i}"
        created: new Date()
        last_update: new Date()
        random: Math.random()*100
        select: getSelect()

        location:
          type: "Point"
          coordinates: [180*Math.random(), 90*Math.random()]
      for j in [1..5]
        TestSubData.insert
          title: "Sub Item #{i}:#{j}"
          parent: main_id
          comment: "This is a sub doc for #{i}"
          created: new Date()
          last_update: new Date()


  if OtherTestData.find().count() isnt 200
    OtherTestData.remove {}
    for i in [1 .. 200]
      OtherTestData.insert
        name: "#{i} Name"
        value: i
        invert: 500 - i
        comment: "This is a not a comment for #{i}"
        created: new Date()
        last_update: new Date()


  if TestDataAlso.find().count() isnt 200
    TestDataAlso.remove {}
    for i in [1 .. 200]
      TestDataAlso.insert
        name: "#{i} Name"
        value: i
        invert: 500 - i
        comment: "This is a not a comment for #{i}"
        created: new Date()
        last_update: new Date()

  TestData._ensureIndex
    "location": "2dsphere"


  
  testObjs = [
    _id: 1
    name: "yotta"
    symbol: "Y"
    multiplier: "10^24"
  ,
    _id: 2
    name: "zetta"
    symbol: "Z"
    multiplier: "10^21"
  ]

  console.log("Find Test", testObjs)

  ###
  z = testObjs.find (obj) ->
    obj.name is 'zetta'
  ###

  z = _.find testObjs, (obj) ->
    obj.name is 'zetta'

  console.log("z is", z)
  

  #fs.watch '/Users/tep/Projects/meteor/planet9/tests', (monitor) ->
  #  monitor.on "changed", (f, curr, prev) ->
  #    console.log("file changes", f, curr, prev)

