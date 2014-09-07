

statusUpdate = ->
    console.log('statusUpdate')
    CoffeeModal.updateProgressMessage("Still Loading ...")
    Meteor.setTimeout ->
        CoffeeModal.close()
    , 3000

Template.dialogTest.events
    'click #messageTest': ->
        console.log('messageTest')
        CoffeeModal.message('Message Test')
    
    'click #alertTest': ->
        console.log('alertTest')
        CoffeeModal.alert('There was an alert','Alert', 'Alert <i>Test</i>')
    
    'click #errorTest': ->
        console.log('errorTest')
        CoffeeModal.error('There was an error')
    
    'click #confirmTest': =>
        console.log('confirmTest', CoffeeModal)
        CoffeeModal.confirm 'Do it?', (yesNo) ->
            if yesNo
                CoffeeAlerts.success('Doing it!')
            else
                CoffeeAlerts.info('Not doing it!')
    
    'click #promptTest': =>
      console.log('promptTest')
      CoffeeModal.prompt 'Enter something:', (yesNo, returnVal, event) ->
        if yesNo
          if not returnVal
            throw new Meteor.Error(401, "You did not enter anything!")
          CoffeeAlerts.success("You entered #{returnVal}")
        else
          CoffeeAlerts.info('Cancelled')
    
    'click #progressTest': =>
        CoffeeModal.progress('Make some progress ... ', @onProgressCancel)
        @progress = 0
        @progressInterval = Meteor.setInterval(@updateProgress,50)
    
    'click #statusTest': =>
        CoffeeModal.status 'Loading ... ', ->
            console.log("Canceled!")
        Meteor.setTimeout(statusUpdate, 1000)
    
    'click #smallMessageTest': ->
        console.log('smallMessageTest')
        CoffeeModal.smallMessage('Message Test')

    'click #selectTest': =>
        @selectTest()


