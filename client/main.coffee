
Meteor.startup ->
  console.log("Meteor Start on Client")
  
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