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

  @route 'map',
    layoutTemplate: 'mapLayout'

  @route 'profile'
    

if Meteor.isClient
  Router.onBeforeAction (pause) ->
    AccountsEntry.signInRequired(@, pause)

  cleanUp = (pause) ->
    console.log("cleanUp")
    if $('#navbar-collapse')?.hasClass('in')
        $('#navbar-collapse').collapse('hide')


  Router.onStop cleanUp