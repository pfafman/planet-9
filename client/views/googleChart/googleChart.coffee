
chartOptions =
  width:  600
  height: 350
  legend: 'none'
  animation:
    duration: 1000
    easing: 'in'
   chartArea:
    left: 30
    top: 20
    width:'85%'
    height:'75%'
  #curveType: 'function'
  vAxis:
    gridlines:
      color: '#ffffff'
    textPosition: 'out'
    textStyle:
      fontSize: 11
    #viewWindowMode: 'pretty'
  hAxis:
    gridlines:
      color: '#ffffff'
  pointSize: 4
  lineWidth: 2

options = {}

i          = 0
data       = null
intervalId = null
myChart    = null
maxCount   = 100
period     = 25
baseTimestamp = 0


testData = ->
  rows = []
  
  baseTime = moment().subtract(maxCount, "seconds")
  baseTimeStamp = baseTime.unix()
  while i < maxCount
    timestamp = baseTimeStamp + i
    w = 2 * Math.PI * (timestamp-baseTimestamp) / period
    rows.push [
      moment(timestamp).toDate()
      Math.sin(w)
      0.5 * Math.cos(w)
      Math.random() / 3
      Math.cos(w) + Math.random() / 3
    ]
    i++
  #console.log('rows', rows)
  rows

nextPoint = ->
  timestamp = moment().unix()
  w = 2 * Math.PI * (timestamp-baseTimestamp) / period
  rtn = [
    moment(timestamp).toDate()
    Math.sin(w)
    0.5 * Math.cos(w)
    Math.random() / 3
    Math.cos(w) + Math.random() / 3
  ]
  rtn
  

Template.googleChart.created = ->
  i = 0
  @chart     = null
  @chartData = null
  @chartDone = new ReactiveVar(false)
  @googleChartLoaded = new ReactiveVar(false)

  if not google?.visualization?.LineChart?
    GoogleLoader.load =>
      google.load 'visualization', '1.0',
        packages:
          ['corechart']
        callback: =>
          console.log("googleCharts tLoaded")
          @googleChartLoaded.set(true)
  
Template.googleChart.destroyed = ->
  Meteor.clearInterval(intervalId)

Template.googleChart.rendered = ->
  
  @autorun =>
    if @googleChartLoaded.get()
      console.log("autorun")
      if not @chart?
        console.log("create google chart")
        @chartData = new google.visualization.DataTable()
        google.visualization.events.addListener @chartData, 'error', (error) ->
          console.log("DataTable Error", error)

        types = ['time', 'sin', 'cos', 'rand', 'rand2']

        for type in types
          switch type
            when 'time'
              @chartData.addColumn('datetime', 'time')
            else
              @chartData.addColumn('number', type)

        @chartData.addRows(testData())

        #console.log(@chartData.toJSON())

        ###
        data = google.visualization.arrayToDataTable([
          ['Year', 'Sales', 'Expenses'],
          [2004,  1000,      400],
          [2005,  1170,      460],
          [2006,  660,       1120],
          [2007,  1030,      540]
        ])
        ###
        
        @chart = new google.visualization.LineChart(document.getElementById('chart'))
        google.visualization.events.addListener @chart, 'error', (error) ->
          console.log("LineChart Error", error)
        @chart.draw(@chartData, options)

        @chartDone.set(true)

        
        intervalId = Meteor.setInterval =>
          newDataRow = nextPoint()
          #console.log("add row", @chartData.getNumberOfRows(), newDataRow)
          @chartData.insertRows(@chartData.getNumberOfRows(), [newDataRow])
          #console.log("DataTable", @chartData.toJSON())
          @chart.draw(@chartData, options)

          Meteor.setTimeout =>
            while @chartData.getNumberOfRows() > maxCount
              @chartData.removeRow(0)
              @chart.draw(@chartData, options)
          , 100
        , 500

        


    
  # Put here to trigger autrun above
  if google?.visualization?.LineChart?
    @googleChartLoaded.set(true)
    

Template.googleChart.helpers
  haveChart: ->
    #console.log("haveChart", Template.instance().chartDone?.get())
    Template.instance().chartDone?.get()

 

