

Template.instrumentMeasurements.rendered = ->
  #console.log("instrumentMeasurements rendered")
  if not @data.measurements
    @measurements = []
  Session.set("instrumentMeasurements", @data.measurements)


Template.instrumentMeasurements.helpers
  measurements: ->
    if Session.get("instrumentMeasurements")?
      theMeasurements = Session.get("instrumentMeasurements")
      console.log('measurements', theMeasurements)
      index = 0
      for measurement in theMeasurements
        measurement.index = index
        index++
      theMeasurements


Template.instrumentMeasurements.events
  "click #add-measurement": (e) ->
    e.preventDefault()
    if $("#new-measurement").val()
      theMeasurements = Session.get("instrumentMeasurements")
      if not theMeasurements
        theMeasurements = []
      theMeasurements.push
        name: $("#new-measurement").val()
        units: $("#new-units").val()
      Session.set("instrumentMeasurements", theMeasurements)
      $("#new-measurement").val('')
      $("#new-units").val('')
      # save record?
     

  "click .remove-measurement": (e) ->
    e.preventDefault()
    console.log("remove measurement", @)
    theMeasurements = Session.get("instrumentMeasurements")
    theMeasurements.splice(@index, 1)
    Session.set("instrumentMeasurements", theMeasurements)
    # save record?
