
###
console.log("callbackTest File")

class TestDecoder

  constructor: (@callback) ->

  process: ->
    for i in [0..20]
      @callback
        counter: i
      


records = []
decoderCallback = (record) ->
  console.log("add record start", record.counter)
  if record.counter is 0
    console.log("add do loop", record.counter)
    for i in [0,100]
      user = Meteor.users.findOne()
  records.push(record)
  console.log("add record done", record.counter)
  

decoder = new TestDecoder(decoderCallback)
console.log("Process Start", records)
decoder.process()
console.log("Process Done", records.length)

###