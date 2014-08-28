
Template.header.helpers

  pageTitle: ->
    Session.get('pageTitle') or "Planet 9"

  activeRouteClass: ->
    args = Array.prototype.slice.call(arguments, 0)
    if args?.pop?()
      if args?
        active = _.any args, (name) ->
          Router.current?()?.route?.name is name
        active && 'active'

