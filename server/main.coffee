
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