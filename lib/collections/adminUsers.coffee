
#
#  Users collection for Admin
#


Meteor.users.editOk = ->
  Meteor.users.findOne(Meteor.userId)?.admin

Meteor.users.deleteOk = ->
  Meteor.users.findOne(Meteor.userId)?.admin

Meteor.users.colToUseForName = 'username'

#Meteor.users.publishCounts = false

Meteor.users.schema =
  'username':
    staticOn_edit: true
    edit: false
    canFilterOn: true
    template: 'username'
    display: (val, rec) ->
      rec
      
  'name':
    staticOn_edit: true
         
  'emails':
    header: "Primary Email"
    dataKey: "emails.address"
    staticOn_edit: true
    valueFunc: (val, rec) ->
      rec.emails?[0]?.address
    canFilterOn: true

  'verified':
    valueFunc: (val, rec) ->
      rec.emails?[0]?.verified
    type: 'boolean'
    template: "checkMark"

  'admin':
    edit: true
    insert: false
    type: 'boolean'
    template: "checkMark"

  "createdAt":
    header: "Created"
    edit: false


# Permissions
Meteor.users.allow
  update: isAdmin
  remove: isAdmin

Meteor.methods
  "ironTable_adminUsers_recordCount": ->
    Meteor.users.find().count()

