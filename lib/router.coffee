Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'
    

Router.map ->

  @route 'home',
    path: '/'

  @route 'nvd3Test'

  @route 'dcTest',
    waitOn: ->
      console.log("dcTest waitOn")
      Meteor.subscribe('testDataAll')
    data: ->
      console.log("dcTest data", @ready())
      if @ready()
        data: TestData.find()

  @route 'tableTest',
    path: '/tableTest/:skip?'
    controller: TestTableController

  @route 'editTestData',
    path: '/testData/edit/:_id'
    waitOn: ->
      Meteor.subscribe('testDataRecord', @params._id)
    data: ->
      if @ready()
        data = TestData.findOne
          _id: @params._id
        if not data?
          data = {}
        data.returnPath = "tableTest"
        data

  @route 'addTestData',
    path: '/testData/add'

  @route 'map',
    layoutTemplate: 'mapLayout'

  @route 'profile'

  @route 'gridTest',
    template: 'grid'
    waitOn: ->
      Meteor.subscribe('grid')
    data: ->
      grid: Grid.find()
    

  @route 'epochTest'

  #
  # Admin
  #

  @route 'adminUsers',
    path: '/admin/users/:skip?'
    controller: UserTableController

  @route 'stats',
    path: '/admin/stats'

    

if Meteor.isClient
  Router.onBeforeAction (pause) ->
    AccountsEntry.signInRequired(@, pause)

  cleanUp = (pause) ->
    console.log("cleanUp")
    if $('#navbar-collapse')?.hasClass('in')
        $('#navbar-collapse').collapse('hide')


  Router.onStop cleanUp

  scrollToTop = (pause) ->
    $(window).scrollTop(0)

  Router.onRun scrollToTop

  #Router.onBeforeAction loading
