App.ApplicationRoute = Em.Route.extend
  events: {
    signOut: ->
      controller = @controllerFor('currentSession')
      if session = controller.get('content')
        session.deleteRecord()
        controller.set 'content', null

      @transitionTo 'index'
  }
