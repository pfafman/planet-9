#
# Display a user table for admin users
#

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