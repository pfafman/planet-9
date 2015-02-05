
Template.header.created = ->
  # jQuery to collapse the navbar on scroll
  $(window).scroll ->
    if $(".navbar").offset().top > 50
      $(".navbar-fixed-top").addClass("top-nav-collapse")
    else if $(".navbar").offset().top < 30
      $(".navbar-fixed-top").removeClass("top-nav-collapse")

  Meteor.setTimeout ->
    $('.navbar-custom').removeClass('hide')
    Meteor.defer ->
      $('.navbar-custom').css('opacity', 0.8)
  , 1000


Template.header.rendered = ->
  $.material.init()

Template.header.helpers
  pageTitle: ->
    Session.get('pageTitle') or "Planet 9"


Template.nav.helpers
  activeRouteClass: ->
    args = Array.prototype.slice.call(arguments, 0)
    if args?.pop?()
      if args?
        active = _.any args, (name) ->
          Router.current?()?.route?.getName() is name
        active && 'active'
