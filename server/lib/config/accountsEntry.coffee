

Meteor.startup ->

  if AccountsEntry?
    AccountsEntry.config
      signupCode: 'secret'
      #defaultProfile:
      #    someDefault: 'default'