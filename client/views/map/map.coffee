
# Locals
mapId = 'map-canvas'
map = null
blueDotMarker = null


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


locationMarker = (loc) ->
  
  if not blueDotMarker?
    bdIcon =
      url: '/img/bluedot_retina.gif'
      size: null
      origin: null
      anchor: new google.maps.Point( 9, 9 )
      scaledSize: new google.maps.Size( 19, 19 )

    blueDotMarker = new google.maps.Marker
      position:
        lat: loc.lat
        lng: loc.lng
      flat: true
      icon: bdIcon
      map: map
      optimized: false
      title: "Current Position"
      visible: true
      zIndex: 10
      opacity: 0.8

  #blueDotMarker.setVisible(false)
  blueDotMarker.setPosition
    lat: loc.lat
    lng: loc.lng
  #blueDotMarker.setVisible(true)


Template.map.onCreated ->
  console.log("map created", Geolocation.currentLocation())
  @googleMapsReady = new ReactiveVar(false)

  
Template.map.onRendered ->
  console.log("map rendered", Geolocation.currentLocation())
  resizeMapPane()
  $(window).resize(resizeMapPane)

  @autorun =>
    console.log("Auto Run")
    if HaveGoogleMaps.get()   # Global in lib/google
      if initMap()
        @googleMapsReady.set(true)


  @autorun =>
    if  @googleMapsReady.get()
      console.log("Auto Run Set Location", Geolocation.latLng(), Geolocation.error())
      location = Geolocation.latLng()
      if location?.lat? and location.lng?
        console.log("Pan map to", location)
        map.panTo
          lat: location.lat
          lng: location.lng
        map.setZoom(15)
        locationMarker(location)


  @autorun ->
    if Geolocation.error()
      CoffeeAlerts.alert(Geolocation.error(), "Geolocation Error")
  

Template.map.helpers
  mapIsReady: ->
    Template.instance().googleMapsReady.get()


