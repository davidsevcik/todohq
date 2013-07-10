App.SessionsNewRoute = Ember.Route.extend
  model: ->
    App.Session.createRecord()

  setupController: (controller, model) ->
    controller.set('content', model)
