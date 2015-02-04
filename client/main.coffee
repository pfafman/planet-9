

Meteor.startup ->
  console.log("Meteor Start on Client")
  

  if AccountsEntry?

    #Accounts.ui.config
    #    passwordSignupFields: 'USERNAME_AND_EMAIL'

    AccountsEntry.config
      logo: '/img/logo.png'
      privacyUrl: '/privacy-policy'
      termsUrl: '/terms-of-use'
      homeRoute: '/'
      dashboardRoute: '/'
      showSignupCode: true
      passwordSignupFields: 'USERNAME_AND_EMAIL'
      verifyEmailCallback: (error) ->
        if error
          CoffeeAlerts.error("Error verifying email")
        else
          CoffeeAlerts.success("Email Verified")

  Meteor.defer ->
    if /mobile/i.test(navigator.userAgent)
      console.log('Mobile Device')
      $ ->
        FastClick.attach document.body

    window.fbAsyncInit = ->
      FB.init
        appId      : '806625879400740'
        #status     : true
        xfbml      : true
        version    : 'v2.1'


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

