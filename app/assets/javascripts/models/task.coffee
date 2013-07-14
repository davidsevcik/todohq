App.Task = Em.Model.extend
  id: Em.attr()
  title: Em.attr()
  priority: Em.attr(Number)
  done: Em.attr()

  priorityTitle: Em.computed('priority', ->
    Em.get @constructor.priorities.findProperty('value', @get('priority')), 'title'
  )

  self: Em.computed -> @


App.Task.url = '/tasks'
App.Task.adapter = App.RESTAdapter.create()

App.Task.priorities = [
  {title: 'Top',    value: 2}
  {title: 'High',   value: 1}
  {title: 'Normal', value: 0}
  {title: 'Low',    value: -1}
]


App.Task.reopenClass
  findAllSorted: ->
    # return @_findAllRecordArray if @_findAllRecordArray

    sortFunction = (a, b) ->
      priorityOrder = b.get('priority') - a.get('priority')
      if priorityOrder is 0
        a.get('id') - b.get('id')
      else
        priorityOrder

    records = @_findAllRecordArray = Em.RecordArray.extend(
      Em.SortableMixin, {sortProperties: ['self'], sortFunction: sortFunction}
    ).create()

    @adapter.findAll @, records
    records
