
Template.home.created = ->
  Meteor.setTimeout ->
    $('.home').removeClass('hide')
    #Meteor.defer ->
    #  $('.home').css('opacity', 0.8)
  , 1000


Template.home.events
  'click #to-grid': (e, tmpl) ->
    Router.go '/gridTest'

    #, {}, 
    #  animation: 'slideRight'