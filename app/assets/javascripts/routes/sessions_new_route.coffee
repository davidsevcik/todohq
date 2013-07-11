App.SessionsNewRoute = Ember.Route.extend
  model: ->
    App.Session.create()
