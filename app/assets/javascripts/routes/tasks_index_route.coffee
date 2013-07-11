App.TasksIndexRoute = Em.Route.extend
  model: ->
    if user = @controllerFor('currentUser').get('content')
      user.get('tasks')
    else
      @transitionTo 'sessions.new'
