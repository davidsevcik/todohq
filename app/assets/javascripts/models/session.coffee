App.Session = Em.Model.extend
  email: Em.attr()
  password: Em.attr()
  authenticationToken: Em.attr()

App.Session.url = '/sessions'
App.Session.adapter = App.RESTAdapter.create()
App.Session.camelizeKeys = true


