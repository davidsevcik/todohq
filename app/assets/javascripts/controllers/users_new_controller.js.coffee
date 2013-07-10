App.UsersNewController = Ember.ObjectController.extend
  save: ->
    @content.save().then => @transitionToRoute('index')
