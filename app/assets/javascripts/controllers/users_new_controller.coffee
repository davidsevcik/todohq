App.UsersNewController = Ember.ObjectController.extend
  needs: ['currentSession']
  save: ->
    @get('content').save().then =>
      session = App.Session.create @get('content').getProperties('email', 'authenticationToken')
      @get('controllers.currentSession').set 'content', session
      @transitionToRoute 'tasks.index'

