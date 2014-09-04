
testData = ->
  sin = []
  cos = []
  rand = []
  rand2 = []
  i = 0

  baseTime = moment().subtract(1000, "minutes")

  console.log("date?", baseTime.toDate().getHours())

  while i < 100

    aTime = baseTime.add("minutes", 1).valueOf()
    #if i < 10
    #  console.log("aTime", aTime)
    sin.push #the nulls are to show how defined works
      x: aTime
      y: (if i % 10 is 5 then null else Math.sin(i / 10))

    cos.push
      x: aTime
      y: .5 * Math.cos(i / 10)

    rand.push
      x: aTime
      y: Math.random() / 10

    rand2.push
      x: aTime
      y: Math.cos(i / 10) + Math.random() / 10

    i++
  [
    {
      area: true
      values: sin
      key: "Sine Wave"
      color: "#ff7f0e"
    }
    {
      values: cos
      key: "Cosine Wave"
      color: "#2ca02c"
    }
    {
      values: rand
      key: "Random 1"
      color: "#2222ff"
    }
    {
      values: rand2
      key: "Random 2"
      color: "#667711"
    }
  ]


Template.nvd3Test.created = ->
  console.log("stats created")
  if not data
    data = testData()

  nv.addGraph ->
    if false
      chart = nv.models.lineChart()
    else
      chart = nv.models.lineWithFocusChart()

    if chart.useInteractiveGuideline?()?
      chart.useInteractiveGuideline(true)
    
    chart.xAxis
      .tickFormat (d) ->
        d3.time.format('%I:%M')(new Date(d))
      #.axisLabel("Time (s)")
      
    if chart.x2Axis?
      chart.x2Axis
        .tickFormat (d) ->
          d3.time.format('%I:%M')(new Date(d))
        #.axisLabel("Time (s)")
        
    chart.yAxis.tickFormat d3.format(",.2f")
    
    if chart.y2Axis?
      chart.y2Axis.tickFormat d3.format(",.2f")
    
    d3.select("#chart svg").datum(data).transition().duration(500).call chart
    nv.utils.windowResize chart.update
    #chart.dispatch.on 'stateChange', (e) ->
    #  nv.log('New State:', JSON.stringify(e))
    chart





