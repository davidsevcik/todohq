#= require ./rest_adapter
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./templates
#= require_tree ./routes
#= require ./router


Ember.Application.initializer
  name: 'currentSession'
  initialize: (container) ->
    session = if cookieSession = $.cookie('currentSession')
      App.Session.create JSON.parse(cookieSession)
    else
      null

    sessionController = container.lookup('controller:currentSession')
    App.RESTAdapter.sessionController = sessionController
    sessionController.set 'content', session
    container.typeInjection('controller', 'currentSession', 'controller:currentSession')
