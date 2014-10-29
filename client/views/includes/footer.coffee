Template.footer.rendered = ->
  if not Session.get("cordovaReady")
    $('[rel="tooltip"]').tooltip()

Template.footer.helpers

  connected: ->
    Meteor.status().connected

  disconnectReason: ->
    Meteor.status()?.reason
