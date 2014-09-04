
Meteor.publish 'testData', (select, sort, limit, skip) ->
  TestData.find select, 
    sort: sort
    limit: limit
    skip: skip


Meteor.publish 'testDataAll', ->
  console.log('testDataAll')
  TestData.find()


Meteor.publish 'testDataRecord', (id) ->
  console.log('testDataRecord')
  TestData.find
    _id: id


Meteor.publish 'testDataAlso', ->
  TestDataAlso.find()
