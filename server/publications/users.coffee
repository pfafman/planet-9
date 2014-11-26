
Meteor.publish "userData", ->
  Meteor.users.find
    _id: @userId
  ,
    fields:
      admin: 1
      created: 1


Meteor.publish "ironTable_publish_adminUsers", (select, sort, limit, skip) ->
  cursors = []
  if @userId and Meteor.users.findOne(@userId)?.admin

    publishCount @, "usersCount", Meteor.users.find(select),
      noReady: true

    Meteor.users.find select,
      fields:
        profile: 1
        emails: 1
        createdAt: 1
        username: 1
        admin: 1
        _id: 1
      sort: sort
      limit: limit
      skip: skip


Meteor.publish null, ->
  if @userId and Meteor.users.findOne(@userId)?.admin
    Presences.find()
  
  