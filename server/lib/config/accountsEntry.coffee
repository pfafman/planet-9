


Meteor.startup ->
  AccountsEntry.config
    signupCode: 'secret'
    #defaultProfile:
    #    someDefault: 'default'