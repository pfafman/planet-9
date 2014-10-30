
@GettingGoogleMaps = false
@HaveGoogleMaps = new ReactiveVar(false)

@GoogleMapsInit = ->
  console.log("GoogleMaps initialized on client start", google?.maps, @google)
  GettingGoogleMaps = false
  if google?.maps?
    HaveGoogleMaps.set(true)

Meteor.startup ->
  #Meteor.defer ->
  if not google?.maps?
    console.log("get google maps on startup")
    HaveGoogleMaps.set(false)
    GettingGoogleMaps = true
    $.getScript "https://maps.googleapis.com/maps/api/js?callback=GoogleMapsInit", ( data, textStatus, jqxhr ) ->
      console.log("Load google maps success", data, textStatus, jqxhr)
    .done (script, textStatus) ->
      console.log("Load google maps done", script, textStatus, google)
    .fail (jqxhr, settings, exception) ->
      console.log("Load google maps FAIL!!!", jqxhr, settings, exception)
      CoffeeAlerts.error("Server Error!  Cannot load google maps!")