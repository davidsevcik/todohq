App.IndexRoute = Em.Route.extend
  redirect: ->
    if user = @controllerFor('currentUser').get('content')
      @transitionTo 'tasks.index'
    else
      @transitionTo 'sessions.new'
