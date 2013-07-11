App.Session = Em.Model.extend
  email: Em.attr()
  password: Em.attr()
  user: Em.belongsTo('App.user')

App.Session.url = '/sessions'
App.Session.adapter = Em.RESTAdapter.create()
