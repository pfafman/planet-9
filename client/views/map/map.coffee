
loadingGoogleMaps = false
mapId = 'map-canvas'
map = null

googleMapsLoaded = ->
  console.log("GoogleMaps Loaded")
  loadingGoogleMaps = false
  Session.set('GoogleMapsLoaded',true)


initMap: ->
  console.log("initMap")

  mapOptions = 
    mapTypeId: google.maps.MapTypeId.ROADMAP
    streetViewControl: false
    zoom: 5
    overviewMapControl: true    
    center: new google.maps.LatLng(0.0,90.0)
    scaleControl: true

  map = new google.maps.Map(document.getElementById(mapId), mapOptions)
  
  bikeLayer = new google.maps.BicyclingLayer()
  bikeLayer.setMap(map)
  console.log("Google maps setup complete")

Template.map.created = ->
  if not GoogleLoader?.load?
      console.log("Error: no GoogleLoader", GoogleLoader?)
      CoffeeAlerts.error("Server Error!  Cannot load google maps!")
  else if not loadingGoogleMaps and not Session.get('GoogleMapsLoaded')
    console.log("loadGoogleMaps")
    loadingGoogleMaps = true
    GoogleLoader.load ->
      google.load 'maps', '3',
        callback: googleMapsLoaded
        other_params: 'sensor=false'

Template.map.helpers
  mapIsReady: ->
