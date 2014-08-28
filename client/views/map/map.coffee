
loadingGoogleMaps = false
mapId = 'map-canvas'
map = null

googleMapsLoaded = ->
  console.log("GoogleMaps Loaded")
  loadingGoogleMaps = false
  initMap()
  Session.set('GoogleMapsLoaded',true)


initMap = ->
  console.log("initMap")

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
      

  map = new google.maps.Map(document.getElementById(mapId), mapOptions)
  
  bikeLayer = new google.maps.BicyclingLayer()
  bikeLayer.setMap(map)
  console.log("Google maps setup complete")
  Session.set('GoogleMapsReady',true)
  resizeMapPane()

resizeMapPane = ->
  paneHeight = $(window).height()
  paneHeight -= $('footer').outerHeight() + 20
  paneHeight -= $("nav").outerHeight() + 20
  paneHeight -= 100
  $("##{mapId}").height(paneHeight)

Template.map.created = ->
  console.log("map created")

Template.map.rendered = ->
  console.log("map rendered")
  resizeMapPane()
  $(window).resize(resizeMapPane)
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

Template.map.helpers
  mapIsReady: ->
    Session.get('GoogleMapsReady')
