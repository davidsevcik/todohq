App.UsersNewController = Ember.ObjectController.extend
  needs: ['currentSession']
  save: ->
    @content.save().then((=>
        session = App.Session.create @content.getProperties('email', 'authenticationToken')
        @get('controllers.currentSession').set 'content', session
        @transitionToRoute 'tasks.index'
      ),
      (xhr) =>
        if errors = Em.get(xhr, 'responseJSON.errors')
          camelizedErrors = {}
          camelizedErrors[Em.String.camelize(key)] = value for key, value of errors
          @content.set('errors', camelizedErrors)
    )
