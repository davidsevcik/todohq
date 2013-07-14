App.SessionsNewController = Ember.ObjectController.extend
  needs: ['currentSession']
  save: ->
    @get('content').save().then(((data) =>
        @get('controllers.currentSession').set 'content', @get('content')
        @transitionToRoute 'tasks.index'
      ),
      (xhr) =>
        if errors = Em.get(xhr, 'responseJSON.errors')
          camelizedErrors = {}
          camelizedErrors[Em.String.camelize(key)] = value for key, value of errors
          @content.set('errors', camelizedErrors)
    )
