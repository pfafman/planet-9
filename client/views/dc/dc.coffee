
hourChart   = null
randomChart = null

doGraphs = (query) ->
  data = query.fetch()
  
  numberFormat = d3.format(",f")

  testDataSet = crossfilter(data)

  console.log("Size", testDataSet.size())

  all = testDataSet.groupAll()

  date = testDataSet.dimension (d) ->
    d.created

  dates = date.group(d3.time.day)

  hour = testDataSet.dimension (d) ->
    d.created.getHours() + d.created.getMinutes() / 60
  hours = hour.group(Math.floor)

  random = testDataSet.dimension (d) ->
    d.random
  randoms = random.group(Math.floor)

  console.log("define graphs dc:", dc)
  hourChart   = dc.barChart("#hour-chart")
  randomChart = dc.barChart("#random-chart")
  
  console.log("set graphs 1")
  hourChart
  .width(500)
  .height(300)
  .margins({top: 10, right: 50, bottom: 40, left: 40})
  .dimension(hour)
  .group(hours)
  .elasticY(true)
  .centerBar(true)
  .gap(1)
  .round(dc.round.floor)
  .alwaysUseRounding(true)
  .x(d3.scale.linear().domain([0, 24]))
  .renderHorizontalGridLines(true)
  .filterPrinter (filters) ->
      filter = filters[0]
      numberFormat(filter[0]) + " -> " + numberFormat(filter[1])

  #hourChart.xAxis().tickFormat (v) ->
  #  v + "%";
  hourChart.yAxis().ticks(5)

  console.log("set graph 2")
  
  randomChart
  .width(500)
  .height(300)
  .margins({top: 10, right: 50, bottom: 40, left: 40})
  .dimension(random)
  .group(randoms)
  .elasticY(true)
  .centerBar(true)
  .gap(1)
  .round(dc.round.floor)
  .alwaysUseRounding(true)
  .x(d3.scale.linear().domain([0, 100]))
  .renderHorizontalGridLines(true)
  .renderTitle(true)
  .filterPrinter (filters) ->
      filter = filters[0]
      numberFormat(filter[0]) + " -> " + numberFormat(filter[1])

  #randomChart.xAxis().tickFormat (v) ->
  #  v + "%";
  randomChart.yAxis().ticks(5)

  dc.dataCount(".dc-data-count")
  .dimension(testDataSet)
  .group(all)

  dc.renderAll()
  d3.selectAll("#version").text(dc.version)
  console.log("done")


Template.dcTest.rendered = ->
  console.log('dcTest rendered')


Template.dcTest.helpers
  haveData: ->
    @data?

Template.dcTest.events

  "click #reset-time-of-day": (e) ->
    hourChart?.filterAll?()
    dc.redrawAll()

  "click #reset-random": (e) ->
    randomChart?.filterAll?()
    dc.redrawAll()


Template.dcCharts.rendered = ->
  console.log("dcCharts rendered", @data?.data?)
  doGraphs(@data?.data)
  