

Template.canvas.rendered = ->
  console.log("canvas rendered", @find('.main'))
  Bender.initialize(@find('.main'))
  Bender.animate('fadeOut')