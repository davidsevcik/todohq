App.CurrentSessionController = Ember.ObjectController.extend
  isSignedIn: Em.computed.notEmpty('content.authenticationToken')

  contentDidChange: (->
    if Em.isEmpty @get('content.authenticationToken')
      $.removeCookie 'currentSession'
    else
      json = JSON.stringify @get('content').getProperties('email', 'authenticationToken')
      $.cookie 'currentSession', json
  ).observes('content')
