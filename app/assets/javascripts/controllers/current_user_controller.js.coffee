App.CurrentUserController = Ember.ObjectController.extend
  isSignedIn: Em.computed.bool('content.isLoaded')
