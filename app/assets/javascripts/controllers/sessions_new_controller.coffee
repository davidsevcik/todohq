App.SessionsNewController = Ember.ObjectController.extend
  needs: ['currentSession']
  save: ->
    @content.save().then(((xhr) =>
        @get('controllers.currentSession').set 'content', @content
        @transitionToRoute 'tasks.index'
      ),
      (xhr) =>
        if errors = Em.get(xhr, 'responseJSON.errors')
          camelizedErrors = {}
          camelizedErrors[Em.String.camelize(key)] = value for key, value of errors
          @content.set('errors', camelizedErrors)
    )
