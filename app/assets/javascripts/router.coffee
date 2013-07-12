App.Router.map ->
  @resource 'users', ->
    @route 'new'

  @resource 'sessions', ->
    @route 'new'

  @resource 'tasks', ->
    @route 'index'
