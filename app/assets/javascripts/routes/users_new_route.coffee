App.UsersNewRoute = Ember.Route.extend
  activate: ->
    @transitionTo 'tasks.index' if @controllerFor('currentSession').get('content')

  model: ->
    App.User.create()
