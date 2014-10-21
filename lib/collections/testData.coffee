
# Make sure collection is global with '@'

#
#  Test collection
#

@TestDataAlso = new Mongo.Collection("testDataAlso")


class TestDataCollection extends IronTableCollection
  classID: 'TestData'

  recordName: 'Test Record'
  colToUseForName : 'title'
  methodOnInsert  : 'insertTestDataRecord'
  methodOnUpdate  : 'updateTestDataRecord'
  methodOnRemove  : 'removeTestDataRecord'

  doRowLink : true

  downloadFields:
    'title': 1
    'value': 1
    'invert': 1
    'comment': 1
    'created': 1
    'random': 1
    'last_update': 1
    'location.coordinates.0': 1
    'location.coordinates.1': 1


  schema:
    'title':
      placeholder: 'enter a name ...'
      required: true
      edit: true
      contenteditable: true
      insert: true
      autofocus: true
      staticOn_edit: true
      tooltip: 'Enter whatever you like'
      canFilterOn: true
      helpText: 'Just a title'
    'value':
      dataKey: 'value'
      edit: false
      contenteditable: true
      insert: false
      type: 'number'
      canFilterOn: true
      onInsert: ->
        throw new Meteor.Error(401, 'Test Throw') unless Session.get("testDataValue")?
        Session.get("testDataValue")
    'invert':
      edit: false
      insert: false
      contenteditable: true
      type: 'number'
      canFilterOn: true
    'location':
      noSort: true
      target: '_blank'
      link: (col, rec) ->
        if rec.location?.coordinates?[0]? and rec.location?.coordinates?[1]?
          "https://maps.google.com/maps?q=#{rec.location.coordinates[0]},#{rec.location.coordinates[1]}&num=1&vpsrc=0&ie=UTF8&t=m&z=13&iwloc=A"
      display: (col, rec) ->
        if rec.location?.coordinates?[0]? and rec.location?.coordinates?[1]?
          lat = rec.location.coordinates[0].toFixed(3)
          lng = rec.location.coordinates[1].toFixed(3)
          "(#{lat}, #{lng})"
    'comment':
      edit: true
      insert: true
      contenteditable: true
      class: "hidden-xs"
      type: 'textarea'
      canFilterOn: true
      helpText: "Do you need some help?"
    'switch':
      edit: true
      contenteditable: true
      insert: false
      type: 'boolean'
      #checkedMark: 'fa-check-circle'
      #blankOnNotChecked: true
      #template: 'checkMark'  # Use the canned one
    'select':
      edit: true
      contenteditable: true
      insert: true
      type: 'select'
      select: [
        'zero'
        'one'
        'two'
        'three'
      ]
    'created':
      edit: false
      insert: false
      onInsert: newDate
      valueFunc: Format.DateTime
      class: 'visible-lg'
    'last_update':
      header: "updated"
      edit: false
      insert: false
      onUpdate: newDate
      onInsert: newDate
      valueFunc: Format.DateTime

  
  deleteOk: (record) ->
    isAdminOrOwner( Meteor.userId(), record)

  editOk: (record) ->
    isAdminOrOwner( Meteor.userId(), record)

  insertOk: (record) ->
    true

  remove: (select, callback) ->
    # Do something here

    @find(select)?.forEach (record) ->
      TestSubData.remove
        parent: record._id
      , (error) ->
        if error
          Meteor.throw('400', "Error deleting sub records: #{error.reason}")
    super


@TestData = new TestDataCollection('testData')

# Client Side Permissions
TestData.allow
  update: isUser #isAdmin
  remove: isUser #isAdmin
  insert: isUser #isAdmin

###
if Meteor.isServer
  TestDataTable = new DataTableComponent
    subscription: "jTestTable"
    collection: TestData

  TestDataTable.publish()
###

# Add a method to do server side delete
Meteor.methods
  removeTestDataRecord: (select) ->
    user = Meteor.user()
    throw new Meteor.Error(401, "Need to be logged in") unless user

    if not user.admin
      # Add in select for ownership
      console.log('removeTestDataRecord not admin')

    TestData.remove select, (error) ->
      if error
        Meteor.throw('400', "Error deleting Test Record: #{error.reason}")


  updateTestDataRecord: (_id, attributes) ->
    user = Meteor.user()
    throw new Meteor.Error(401, "You need to login to update a instrument") unless user
    throw new Meteor.Error(422, "No instrument type to update") unless _id

    if attributes.measurements?
      measurements = []
      for key, val of attributes.measurements
        measurements.push val
      attributes.measurements = measurements

    instrumentType = _.extend attributes,
      changed: new Date().getTime()
      updaterId: user._id

    select =
      _id: _id

    if not user.admin
      select.ownerId = user._id

    TestData.update select,
      $set: instrumentType


  insertTestDataRecord: (attributes) ->
    user = Meteor.user()
    throw new Meteor.Error(401, "You need to login to add data")  unless user

    invalidKeys = []
    if not attributes.title
      invalidKeys.push
        name: "title"
        message: "You must enter a title"

    if invalidKeys.length > 0
      error:
        invalidKeys: invalidKeys
    else
      console.log('insertTestDataRecord', attributes, attributes.measurements)

      if attributes.measurements?
        # Convert Object to an Array
        measurements = []
        for key, val of attributes.measurements
          measurements.push val
        attributes.measurements = measurements
      console.log('insertTestDataRecord', attributes)
      instrumentType = _.extend attributes,
        ownerId: user._id
        updaterId: user._id
        created: new Date().getTime()
        updated: new Date().getTime()
      TestData.insert(instrumentType)


class TestSubDataCollection extends IronTableCollection
  classID: 'TestSubData'

  recordName: 'Test Sub Record'
  colToUseForName : 'title'

  schema:
    'title':
      placeholder: 'enter a name ...'
      required: true
      edit: true
      insert: true
      autofocus: true
      tooltip: 'Enter whatever you like'
      canFilterOn: true
    'parent':
      edit: false
    'comment':
      edit: true
      class: "hidden-xs"
      canFilterOn: true
    'created':
      edit: false
      insert: false
      onInsert: newDate
      display: Format.DateTime
      class: 'visible-lg'
    'last_update':
      header: "updated"
      edit: false
      insert: false
      onUpdate: newDate
      onInsert: newDate
      display: Format.DateTime

  deleteOk: (record) ->
    true

  editOk: (record) ->
    true


@TestSubData = new TestSubDataCollection('testSubData')

# Permissions
TestSubData.allow
  update: isAdmin
  remove: isAdmin


#
# Other Test Collection
#

class OtherTestDataCollection extends IronTableCollection
  classID: 'OtherTestData'

  recordName: 'Other Record'
  colToUseForName : 'name'

  schema:
    'name':
      placeholder: 'enter a name ...'
      required: true
      edit: true
      insert: true
      autofocus: true
      tooltip: 'Enter whatever you like'
      canFilterOn: true
    'value':
      data: 'counter'
      edit: false
      insert: false
      type: 'number'
      link: (record) ->
        "detail/#{record.value}"
      title: "Show record detail"
      canFilterOn: true
    'invert':
      edit: false
      insert: false
      type: 'number'
      display: (val, record) ->
        "Function Test " + record['invert']
      canFilterOn: true
    'comment':
      edit: true
      class: "hidden-xs"
      canFilterOn: true
    'created':
      edit: false
      insert: false
      onInsert: newDate
      display: Format.DateTime
      class: 'visible-lg'
    'last_update':
      header: "updated"
      edit: false
      insert: false
      onUpdate: newDate
      onInsert: newDate
      display: Format.DateTime

  deleteOk: (record) ->
    true

  editOk: (record) ->
    true

  remove: (select, callback) ->
    # Do something here
    console.log("Pre remove stuff", select)
    super

@OtherTestData = new OtherTestDataCollection('otherTestData')

OtherTestData.allow
  update: isAdmin
  remove: isAdmin
