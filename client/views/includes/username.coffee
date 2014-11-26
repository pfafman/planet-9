Template.username.helpers
  online: ->
    presence = Presences.findOne
      userId: @value._id
    presence?.state is 'online'
    

Template.username.events
  'click .impersonate': ->
    console.log("Impersonate")