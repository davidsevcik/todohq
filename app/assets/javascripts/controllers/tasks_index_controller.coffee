App.TasksIndexController = Em.ArrayController.extend
  newTask: null
  sortProperties: ['priority']
  sortAscending: false

  noTasks: Em.computed('content.isLoaded', 'content.@each', ->
    @get('content.isLoaded') && Em.isEmpty @get('content')
  )

  init: ->
    @_super()
    @set 'newTask', App.Task.create()

  create: ->
    task = @get('newTask')
    unless Em.isEmpty task.get('title')?.trim()
      task.set('priority', 0) if Em.isEmpty task.get('priority')
      task.set 'lastCreated', true
      task.save().then(=>
        @set 'newTask', App.Task.create()
      )

  edit: (task) ->
    task.set 'editable', true

  cancelEdit: (task) ->
    task.revert()
    task.set 'editable', false

  update: (task) ->
    task.set 'editable', false
    task.save()

  destroy: (task) ->
    task.deleteRecord()
