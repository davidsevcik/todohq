App.UsersNewRoute = Ember.Route.extend
  model: ->
    App.User.createRecord();

  setupController: (controller, model) ->
    controller.set('content', model)
