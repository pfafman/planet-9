
Template.home.created = ->
  Meteor.setTimeout ->
    $('.home').removeClass('hide')
    Meteor.defer ->
      $('.home').css('opacity', 0.8)
  , 1000