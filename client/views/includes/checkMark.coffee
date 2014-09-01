
Template.checkMark.rendered = ->
  Session.set("ironTableActiveRecordId", null)


Template.checkMark.helpers
  doEdit: ->
    @column?.contenteditable? and Session.get("ironTableActiveRecordId") is @record._id
    

Template.checkMark.events

  "click .check-mark": (e) ->
    console.log('check mark click', @record._id, e)
    Session.set("ironTableActiveRecordId", @record._id)

  "mouseenter .check-mark": (e) ->
    console.log('mouseenter')

  "mouseleave .check-mark": (e) ->
    console.log('mouseleave')
    Session.set("ironTableActiveRecordId", null)

  "mouseleave .check-mark-checkbox": (e) ->
    console.log('mouseleave checkbox')
    Session.set("ironTableActiveRecordId", null)
    
  "click .check-mark-checkbox": (e) ->
    e.preventDefault()
    e.stopImmediatePropagation()
    console.log("change checkbox value", @value)
    if @value
      newValue = false
    else
      newValue = true

    if Router.current?()?.classID is "IronTableController"
      console.log("Submit Value Change", @dataKey, @value, '->', newValue)
      data = {}
      data[@dataKey] = newValue
      Router.current().updateThisRecord?(@record._id, data, 'inlineUpdate')
