
Template.controlTests.rendered = ->
  console.log("controlTests rendered")
  $('#units').bootstrapSwitch()



Template.controlTests.helpers
  
  shareConfig: ->
    console.log("shareConfig", Meteor.absoluteUrl())
    rtn =
      href: Meteor.absoluteUrl()