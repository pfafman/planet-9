

i          = 0
data       = null
intervalId = null
myChart    = null


testData = ->
  sin = []
  cos = []
  rand = []
  rand2 = []
  
  baseTime = moment().subtract(100, "seconds")

  console.log("date?", baseTime.toDate().getHours())

  while i < 100

    aTime = baseTime.add(1, 'seconds').valueOf()
    
    sin.push #the nulls are to show how defined works
      time: aTime
      y: Math.sin(i / 10) #(if i % 10 is 5 then null else Math.sin(i / 10))

    cos.push
      time: aTime
      y: .5 * Math.cos(i / 10)

    rand.push
      time: aTime
      y: Math.random() / 10

    rand2.push
      time: aTime
      y: Math.cos(i / 10) + Math.random() / 10

    i++

  [
    {
      values: sin
      label: "Sine Wave"
      #color: "#ff7f0e"
    }
    {
      values: cos
      label: "Cosine Wave"
      #color: "#2ca02c"
    }
    {
      values: rand
      label: "Random 1"
      #color: "#2222ff"
    }
    {
      values: rand2
      label: "Random 2"
      #color: "#667711"
    }
  ]


nextPoint = ->
  aTime = moment().valueOf()
  sin = []
  cos = []
  rand = []
  rand2 = []

  sin = #the nulls are to show how defined works
    time: aTime
    y: Math.sin(i / 10) #(if i % 10 is 5 then null else Math.sin(i / 10))

  cos =
    time: aTime
    y: .5 * Math.cos(i / 10)

  rand =
    time: aTime
    y: Math.random() / 10

  rand2 =
    time: aTime
    y: Math.cos(i / 10) + Math.random() / 10

  i++
  [ sin, cos, rand, rand2 ]


Template.epochTest.created = ->
  console.log("stats created")
  if not data?
    data = testData()
  intervalId = Meteor.setInterval ->
    newPoint = nextPoint()
    myChart.push(newPoint)
  , 1000


Template.epochTest.destroyed = ->
  Meteor.clearInterval(intervalId)


Template.epochTest.rendered = ->
  myChart = $('#chart').epoch
    type: 'time.line'
    data: data
    windowSize: 100
    axes: ['bottom', 'left']
    tickFormats: 
      bottom: (d) -> 
        moment(d).format('hh:mm:ss')
      top: (d) ->
        ''

  console.log(myChart.option())
  




