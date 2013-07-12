App.IndexRoute = Em.Route.extend
  redirect: ->
    if user = @controllerFor('currentSession').get('content')
      @transitionTo 'tasks.index'
    else
      @transitionTo 'sessions.new'
