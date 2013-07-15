#= require ./rest_adapter
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
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
    sessionController.set 'content', session
    container.typeInjection('controller', 'currentSession', 'controller:currentSession')


Ember.Application.initializer
  name: 'flashMessages'
  initialize: (container) ->
    container.lookup('controller:flashMessages')
    container.typeInjection('view', 'flashMessages', 'controller:flashMessages')


Ember.Application.initializer
  name: 'restAdapter'
  initialize: (container) ->
    App.RESTAdapter.sessionController = container.lookup('controller:currentSession')
    App.RESTAdapter.router = container.lookup('router:main')
