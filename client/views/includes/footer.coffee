Template.footer.rendered = ->
  if not Session.get("cordovaReady")
    $('[rel="tooltip"]').tooltip()

Template.footer.helpers

  connected: ->
    Meteor.status().connected

  disconnectReason: ->
    Meteor.status()?.reason


Template.footer.events
  'click .facts-btn': (e, tmpl) ->
    $('.facts').toggleClass('hidden')
    