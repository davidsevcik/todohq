App.IndexRoute = Em.Route.extend
  redirect: ->
    if @controllerFor('currentSession').get('content')
      @transitionTo 'tasks.index'
    else
      @transitionTo 'sessions.new'
