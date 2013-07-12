App.TasksIndexRoute = Em.Route.extend
  model: ->
    if user = @controllerFor('currentSession').get('content')
      user.get('tasks')
    else
      @transitionTo 'sessions.new'
