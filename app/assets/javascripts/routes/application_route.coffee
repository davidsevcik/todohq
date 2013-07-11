App.ApplicationRoute = Em.Route.extend
  events: {
    userDidLogin: (user) ->
      # userJSON = user.toJSON()
      # userJSON.id = 'current'
      # object = @get('store').load(App.User, userJSON)
      # user = App.User.find('current')
      @controllerFor('currentUser').set 'content', user
      @transitionTo 'tasks.index'
  }
