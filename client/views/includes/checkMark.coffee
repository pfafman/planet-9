
Template.checkMark.rendered = ->
  Session.set("checkMarkEditRecordId", null)


Template.checkMark.helpers
  doEdit: ->
    Session.get("checkMarkEditRecordId") is @record._id
    

Template.checkMark.events

  "click .check-mark": (e) ->
    console.log('check mark click', @record._id, e)
    Session.set("checkMarkEditRecordId", @record._id)

  "mouseout .check-mark": (e) ->
    Session.set("checkMarkEditRecordId", null)
    
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
