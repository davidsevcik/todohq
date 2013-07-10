#= require ./store
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views
#= require_tree ./helpers
#= require_tree ./templates
#= require_tree ./routes
#= require ./router


Ember.Application.initializer
  name: 'currentUser'
  initialize: (container) ->
    store = container.lookup('store:main')
    user = App.User.find('current')
    container.lookup('controller:currentUser').set('content', user)
    container.typeInjection('controller', 'currentUser', 'controller:currentUser')
