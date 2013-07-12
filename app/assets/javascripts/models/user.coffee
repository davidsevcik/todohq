App.User = Em.Model.extend
  id: Em.attr()
  email: Em.attr()
  password: Em.attr()
  passwordConfirmation: Em.attr()
  authenticationToken: Em.attr()


App.User.url = '/users'
App.User.adapter = Em.RESTAdapter.create()
App.User.camelizeKeys = true
