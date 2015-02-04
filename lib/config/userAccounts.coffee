
if AccountsTemplates?

  # Routes
  
  AccountsTemplates.configureRoute('changePwd')
  AccountsTemplates.configureRoute('enrollAccount')
  AccountsTemplates.configureRoute('forgotPwd')
  AccountsTemplates.configureRoute('resetPwd')
  AccountsTemplates.configureRoute('signIn')
  AccountsTemplates.configureRoute('signUp')
  AccountsTemplates.configureRoute('verifyEmail')

  
  AccountsTemplates.removeField('email')
  pwd = AccountsTemplates.removeField('password')
  AccountsTemplates.addFields [
      _id: "username"
      type: "text"
      displayName: "username"
      required: true
      minLength: 3
    ,
      _id: 'email'
      type: 'email'
      required: true
      displayName: "email"
      re: /.+@(.+){2,}\.(.+){2,}/
      errStr: 'Invalid email'
    ,
      pwd
    ]


  # Almost complete example of options configuration
  AccountsTemplates.configure
    # Behaviour
    confirmPassword: false
    enablePasswordChange: true
    forbidClientAccountCreation: false
    overrideLoginErrors: false
    sendVerificationEmail: true

    # Appearance
    showAddRemoveServices: false
    showForgotPasswordLink: true
    showLabels: true
    showPlaceholders: true

    # Client-side Validation
    continuousValidation: false
    negativeFeedback: false
    negativeValidation: true
    positiveValidation: true
    positiveFeedback: true
    showValidating: true

    # Privacy Policy and Terms of Use
    privacyUrl: 'privacy'
    termsUrl: 'terms-of-use'

    # Redirects
    homeRoutePath: '/'
    redirectTimeout: 4000

    # Hooks
    #onLogoutHook: myLogoutFunc,
    #onSubmitHook: mySubmitFunc,

    # Texts
    texts:
      button:
        signUp: "Sign Up"
      socialSignUp: "Register"
      socialIcons:
        "meteor-developer": "fa fa-rocket"
      title:
        forgotPwd: "Recover Your Password"
        signIn: ''


