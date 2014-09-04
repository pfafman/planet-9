

UI.registerHelper 'pluralize', (n, thing) -> # fairly stupid pluralizer
    if n is 1
        '1 ' + thing
    else
        n + ' ' + thing + 's'


UI.registerHelper 'admin', ->
  Meteor.user()?.admin


UI.registerHelper 'capitalize', (str) ->
  str.charAt(0).toUpperCase() + str.slice(1)
  