

@Grid = new Meteor.Collection('grid')

# Client Side Permissions
Grid.allow
  update: isUser #isAdmin
  remove: isUser #isAdmin
  insert: isUser #isAdmin
