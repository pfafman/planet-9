
Template.controlTests.rendered = ->
  console.log("controlTests rendered")
  $('#units').bootstrapSwitch()


Template.controlTests.helpers
  
  shareConfig: ->
    rtn =
      href: Meteor.absoluteUrl()


Template.controlTests.events
  'click .fb-test': (e) ->
    console.log("FB Test")
    FB.ui
      #app_id      : '806625879400740'
      method: 'share'
      href: "http://planet9.pfafman.com" #Meteor.absoluteUrl()
    , (response) ->
      console.log("response", response)