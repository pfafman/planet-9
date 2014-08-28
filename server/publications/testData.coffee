
Meteor.publish 'testData', (select, sort, limit, skip) ->
  TestData.find select, 
    sort: sort
    limit: limit
    skip: skip

Meteor.publish 'testDataAll', ->
  console.log('testDataAll')
  TestData.find()


Meteor.publish 'testDataAlso', ->
  TestDataAlso.find()
