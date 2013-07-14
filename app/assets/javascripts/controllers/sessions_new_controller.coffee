App.SessionsNewController = Ember.ObjectController.extend
  needs: ['currentSession']
  save: ->
    @get('content').save().then =>
      @get('controllers.currentSession').set 'content', @get('content')
      @transitionToRoute 'tasks.index'

