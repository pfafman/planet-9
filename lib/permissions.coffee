#
#  Allow and Deny Helpers
#


# check that the userId specified owns the documents
@ownsDocument = (userId, doc) ->
  doc?.userId is userId

# check if the user is an Admin
@isAdmin = (userId, doc) ->
  user = Meteor.users.findOne(userId)
  doc? and user.admin

@isAdminOrOwner = (userId, doc) ->
  ownsDocument(userId, doc) or isAdmin(userId, doc)

@isUser = (userId, doc) ->
  userId?
