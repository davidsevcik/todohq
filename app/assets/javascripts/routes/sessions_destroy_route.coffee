App.SessionsDestroyRoute = Ember.Route.extend
  enter: ->
    controller = @controllerFor('currentUser')
    controller.set('content', undefined)

    App.Session.find('current').then (session) ->
      session.deleteRecord()
      controller.store.commit()

    @transitionTo('index')
