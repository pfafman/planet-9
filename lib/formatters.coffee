


class @Format

  @DurationFullSeconds: (seconds, rec) ->
    Format.Duration(seconds, rec, true)

  @Duration: (seconds, rec, fullseconds=false) ->
    remaining = seconds
    result = ""
    separator = ":"
    units = [
      86400   #secondsInADay
      3600    #secondsInAnHour
      60      #secondsInAMinute
      1       #secondsInASecond
    ]
    whichUnit = 0

    while whichUnit < units.length
      millisecondsInUnit = units[whichUnit]
      totalOfUnit = parseInt(remaining / millisecondsInUnit)
      if whichUnit isnt 0 or totalOfUnit isnt 0
        result += "0"  if totalOfUnit < 10
        result = result + totalOfUnit.toString()
        result += separator  if whichUnit < units.length - 1
      remaining = remaining - (totalOfUnit * millisecondsInUnit)
      whichUnit++
    if fullseconds
      result += "#{remaining.toFixed(1)}".slice(1)
    result

  @Distance: (meters) ->
    km = (Math.round(meters/10)/100).toFixed(2)
    "#{km} km"

  @Speed: (mps) ->
    kph = (Math.round(3.6*mps*10)/10).toFixed(1)
    "#{kph} kph"

  @Heartrate: (bpm) ->
    bpm = Math.round(bpm)
    "#{bpm} bpm"

  @Date: (time) ->
    moment(time).format('L LT')

  @DateTime: (time) ->
    moment(time).format('L HH:mm:ss')

  @DateTimeFrac: (time) ->
    moment(time).format('L HH:mm:ss.S')

    
@ShowUserName = (_id, record) ->
  user = Meteor.users.findOne
    _id: _id
  user?.profile?.name or user?.username or user?.emails[0].address
    

