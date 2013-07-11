App.SessionsNewController = Ember.ObjectController.extend
  needs: ['currentUser']
  save: ->
    @content.save().then((=>
        @get('controllers.currentUser').set 'content', @content.get('user')
        @transitionToRoute 'tasks.index'
      ),
      (xhr) =>
        if errors = Em.get(xhr, 'responseJSON.errors')
          camelizedErrors = {}
          camelizedErrors[Em.String.camelize(key)] = value for key, value of errors
          @content.set('errors', camelizedErrors)
    )
