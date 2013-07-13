App.TasksIndexRoute = Em.Route.extend
  model: -> App.Task.findAllSorted()

