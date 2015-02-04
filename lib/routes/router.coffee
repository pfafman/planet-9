Router.configure
  layoutTemplate: 'layout'
  loadingTemplate: 'loading'
  notFoundTemplate: 'notFound'


Router.map ->

  @route 'home',
    path: '/'

  @route 'nvd3Test'

  @route 'watchFiles'

  @route 'dcTest',
    waitOn: ->
      console.log("dcTest waitOn")
      Meteor.subscribe('testDataAll')
    data: ->
      console.log("dcTest data", @ready())
      if @ready()
        data: TestData.find()

  @route 'tableTest',
    path: '/tableTest'
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

  @route 'googleChart'

  @route 'controlTests'

  @route 'dialogTest'

  @route 'materialize'

  #
  # Admin
  #

  @route 'adminUsers',
    path: '/admin/users'
    controller: UserTableController

  @route 'stats',
    path: '/admin/stats'

    
    
  cleanUp = ->
    console.log("cleanUp")
    #$('[rel="tooltip"]').tooltip('destroy')
    #$('[rel="popover"]').popover('destroy')
    if $('#navbar-collapse')?.hasClass('in')
      $('#navbar-collapse').collapse('hide')
    if $('#navmenu-side').hasClass('in')
      $('#navmenu-side')?.offcanvas('hide')


  Router.onStop cleanUp

  scrollToTop = ->
    $(window).scrollTop(0)
    @next()

  Router.onRun scrollToTop

  ###
  # Messes up tables
  Router.plugin 'loading',
    loadingTemplate: 'loading'
  ###

  Router.plugin 'dataNotFound',
    dataNotFoundTemplate: 'notFound'


if Meteor.isClient
  Router.onBeforeAction ->
    if not this.ready() or Meteor.loggingIn()
      @render('loading')
    else
      @next()


  Router.onBeforeAction AccountsTemplates.ensureSignedIn,
    except: AccountsTemplates.knownRoutes #['atSignIn', 'atSignUp', 'atForgotPassword']

  Router.onBeforeAction ->
    AccountsTemplates.clearError()
  ,
    only: AccountsTemplates.knownRoutes


  #Router.onAfterAction ->
  #  console.log("onAfterAction init material")
  #  $.material.init()

