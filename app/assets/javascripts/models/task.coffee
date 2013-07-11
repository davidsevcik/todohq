App.Task = Em.Model.extend
  id: Em.attr()
  title: Em.attr()
  priority: Em.attr(Number)
  done: Em.attr()

App.Task.url = '/tasks'
App.Task.adapter = Em.RESTAdapter.create()
