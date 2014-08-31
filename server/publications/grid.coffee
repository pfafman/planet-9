
Meteor.publish 'grid', ->
  # For testing send all the grids
  Grid.find()