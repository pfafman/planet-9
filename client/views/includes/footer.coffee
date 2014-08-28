Template.footer.rendered = ->
  if not Session.get("cordovaReady")
    console.log("setup tooltip")
    $('[rel="tooltip"]').tooltip()

Template.footer.helpers

  connected: ->
    Meteor.status().connected

  disconnectReason: ->
    Meteor.status()?.reason
