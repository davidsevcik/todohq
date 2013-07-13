App.TasksIndexView = Em.View.extend
  classNames: ['task-list']
  highlightAddedTasks: false

  taskCreationObserver: (->
    @set('highlightAddedTasks', true) if @get('controller.newTask.isSaving')
  ).observes('controller.newTask.isSaving')


  taskCollectionViewClass: Em.CollectionView.extend
    tagName: 'ul'
    itemViewClass: Em.View.extend
      titleViewClass: Em.View.extend
        tagName: 'span'
        classNameBindings: 'priorityClass task.done:done'.w()
        task: Em.computed.oneWay 'parentView.content'
        priorityClass: Em.computed('task.priorityTitle', ->
          'priority-' + @get('task.priorityTitle')?.toLowerCase()
        )
        template: Em.Handlebars.compile '{{view.task.title}}'

      priorityViewClass: Em.View.extend
        tagName: 'span'
        classNames: 'label pull-right'.w()
        classNameBindings: ['labelClass']
        task: Em.computed.oneWay 'parentView.content'
        labelClass: Em.computed('task.priority', ->
          name = switch @get('task.priority')
            when 2 then 'important'
            when 1 then 'warning'
            when 0 then 'info'
          "label-#{name}" if name
        )
        template: Em.Handlebars.compile '{{view.task.priorityTitle}}'

      doneCheckboxClass: Em.Checkbox.extend
        task: Em.computed.oneWay 'parentView.content'
        checked: Em.computed (key, value) ->
          if value is undefined
            @get 'task.done'
          else
            @set 'task.done', value
            @get('task').save()


      editTaskFormClass: Em.View.extend
        tagName: 'form'
        didInsertElement: ->
          @$('input:text').focus()

      didInsertElement: ->
        if @get('parentView.parentView.highlightAddedTasks')
          @$().effect 'highlight', {}, 2000



  newTaskFormClass: Em.View.extend
    tagName: 'form'
    newTaskDidChange: (->
      @$('.new-task-input').focus()
    ).observes('content')

    didInsertElement: ->
      @$('.new-task-input').focus()


