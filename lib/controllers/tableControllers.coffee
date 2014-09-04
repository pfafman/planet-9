
class @UserTableController extends IronTableController
  tableTitle      : "Users"
  sortColumn      : 'username'
  increment       : 10
  collection      : -> Meteor.users
  collectionName  : 'adminUsers'
  recordName      : 'user'
  showFilter      : true
  fastRender      : DO_FAST_RENDER
  doDownloadLink  : true
  inabox          : true
 

class @TestTableController extends IronTableController
  tableTitle       : "Test Table"
  sortColumn       : 'value'
  increment        : 10
  showBackButton   : true
  showNewButton    : true
  #newRecordRoute   : 'addTestData'
  #editRecordRoute  : 'editTestData'
  formTemplate     : 'testDataForm'
  newRecordTitle   : 'New Record'
  newRecordTooltip : 'Add a new record'
  doDownloadLink   : true
  collection       : -> TestData
  showFilter       : true
  fastRender       : DO_FAST_RENDER
  inabox           : true
  extraControlsTemplate: "testLink"

  
  #yieldTemplates:
  #  'beforeTest':
  #    to: 'beforeMain'
  #    data: ->
  #      comment: 'test'

  action: ->
    console.log('action')
    @render()

    @render 'beforeTest',
      to: 'beforeMain'
      data: ->
        conosle.log("beforeTest data")
        comment: 'test'

  onRun: ->
    super
    console.log('TestTableController onRun')
    Session.set("testDataValue", 100)

  #data: ->
  #  console.log("TestTable data")
  #  super


  # Override the removeRecord Function
  removeRecord: (rec) =>
    console.log("Remove Test Data Record", rec._id, @isSimulation)
    name = rec.recordDisplayName
    Meteor.call 'removeTestDataRecord', {_id: rec._id}, (error) ->
      if error
        console.log("Error deleting #{name}", error)
        CoffeeAlerts.error("Error deleting #{name}: #{error.reason}")
      else
        CoffeeAlerts.success("Deleted #{name}")
    @fetchRecordCount()


class @OtherTestTableController extends IronTableController
  tableTitle      : "Other Test Table"
  sortColumn      : 'name'
  increment       : 12
  collection      : -> OtherTestData
  showFilter      : true
  fastRender      : DO_FAST_RENDER
  doDownloadLink   : true
  waitOn: ->
    subs = [super]


class @DevicesTableController extends IronTableController
  tableTitle       : "Devices"
  sortColumn       : 'value'
  increment        : 10
  collection       : -> Devices
  showFilter       : true
  fastRender       : DO_FAST_RENDER
  doDownloadLink   : true
  showNewButton    : true
  newRecordTitle   : 'New Device'
  newRecordTooltip : 'Add a new device'
  inabox           : false

