App.Router.map ->
  @resource 'users', ->
    @route 'new'

  @resource 'sessions', ->
    @route 'new'
    @route 'destroy'

  @resource 'tasks', ->
    @route 'index'
