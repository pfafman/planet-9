

mapId = 'map-canvas'
map = null

###
googleMapsLoaded = ->
  console.log("googleMapsLoaded", google?.maps?)
  initMap()
  #Session.set('GoogleMapsLoaded',true)
###

###
@GoogleMapsInitMapPage = ->
  console.log("GoogleMaps initialized on page", google?.maps)
  if google?.maps?
    googleMapsLoaded()
  else
    console.log("Could not load google maps")
    CoffeeAlerts.error("Server Error!  Cannot load google maps!")
###

initMap = ->
  console.log("initMap", google?.maps)

  mapOptions =
    disableDefaultUI: true
    mapTypeId: google.maps.MapTypeId.ROADMAP
    streetViewControl: false
    zoom: 11
    overviewMapControl: true
    center: new google.maps.LatLng(39.11,-120.031)
    scaleControl: true
    # How you would like to style the map.
    # This is where you would paste any style found on Snazzy Maps.
    styles: [
      {
        featureType: "landscape"
        stylers: [
          {
            saturation: -100
          }
          {
            lightness: 65
          }
          {
            visibility: "on"
          }
        ]
      }
      {
        featureType: "poi"
        stylers: [
          {
            saturation: -100
          }
          {
            lightness: 51
          }
          {
            visibility: "simplified"
          }
        ]
      }
      {
        featureType: "road.highway"
        stylers: [
          {
            saturation: -100
          }
          {
            visibility: "simplified"
          }
        ]
      }
      {
        featureType: "road.arterial"
        stylers: [
          {
            saturation: -100
          }
          {
            lightness: 30
          }
          {
            visibility: "on"
          }
        ]
      }
      {
        featureType: "road.local"
        stylers: [
          {
            saturation: -100
          }
          {
            lightness: 40
          }
          {
            visibility: "on"
          }
        ]
      }
      {
        featureType: "transit"
        stylers: [
          {
            saturation: -100
          }
          {
            visibility: "simplified"
          }
        ]
      }
      {
        featureType: "administrative.province"
        stylers: [visibility: "off"]
      }
      {
        featureType: "water"
        elementType: "labels"
        stylers: [
          {
            visibility: "on"
          }
          {
            lightness: -25
          }
          {
            saturation: -100
          }
        ]
      }
      {
        featureType: "water"
        elementType: "geometry"
        stylers: [
          {
            hue: "#ffff00"
          }
          {
            lightness: -25
          }
          {
            saturation: -97
          }
        ]
      }
    ]
      
  console.log("make map", mapId, document.getElementById(mapId))
  if document.getElementById(mapId)?
    map = new google.maps.Map(document.getElementById(mapId), mapOptions)
  
    bikeLayer = new google.maps.BicyclingLayer()
    bikeLayer.setMap(map)
    console.log("Google maps setup complete")
    resizeMapPane()
    true
  else
    false

resizeMapPane = ->
  paneHeight = $(window).height()
  paneHeight -= $('footer').outerHeight() + 20
  paneHeight -= $("nav").outerHeight() + 20
  paneHeight -= 100
  $("##{mapId}").height(paneHeight)

Template.map.created = ->
  console.log("map created")
  @googleMapsReady = new ReactiveVar(false)
  

Template.map.rendered = ->
  console.log("map rendered")
  resizeMapPane()
  $(window).resize(resizeMapPane)

  @autorun =>
    console.log("Auto Run")
    if HaveGoogleMaps.get()
      if initMap()
        @googleMapsReady.set(true)

  #console.log("Google Map check", google?.maps?, window.GettingGoogleMaps, HaveGoogleMaps.get())
  ###
  if not google?.maps? and not GettingGoogleMaps
    console.log("Getting maps on page")
    HaveGoogleMaps.set(false)
    GettingGoogleMaps = true
    $.getScript "https://maps.googleapis.com/maps/api/js?callback=GoogleMapsInitMapPage", ( data, textStatus, jqxhr ) ->
      console.log("Load google maps success", data, textStatus, jqxhr)
    .done (script, textStatus) ->
      console.log("Load google maps done", script, textStatus, google)
    .fail (jqxhr, settings, exception) ->
      console.log("Load google maps FAIL!!!", jqxhr, settings, exception)
      CoffeeAlerts.error("Server Error!  Cannot load google maps!")
  ###

  

  ###
  if not GoogleLoader?.load?
      console.log("Error: no GoogleLoader", GoogleLoader?)
      CoffeeAlerts.error("Server Error!  Cannot load google maps!")
  else if not loadingGoogleMaps
    #and not Session.get('GoogleMapsLoaded')
    #Session.get('GoogleMapsLoaded')
    console.log("loadGoogleMaps")
    loadingGoogleMaps = true
    GoogleLoader.load ->
      google.load 'maps', '3',
        callback: googleMapsLoaded
        other_params: 'sensor=false'
  ###

Template.map.helpers
  mapIsReady: ->
    Template.instance().googleMapsReady.get()


