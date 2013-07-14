App.RESTAdapter = Ember.RESTAdapter.extend

  createRecord: (record) ->
    @_super(record).then ((data) -> data), (xhr) => @_failHandling(xhr, record)

  saveRecord: (record) ->
    @_super(record).then ((data) -> data), (xhr) => @_failHandling(xhr, record)

  buildURL: (klass, id) ->
    url = @_super(klass, id)
    if session = @constructor.sessionController.get('content')
      url += "?auth_token=#{session.get('authenticationToken')}"
    url

  ajax: ->
    @_super.apply(@, arguments).then(((data) -> data), (xhr) =>
      @constructor.router.send 'unauthorized' if xhr.status is 401
      xhr
    )

  _failHandling: (xhr, record) ->
    if errors = Em.get(xhr, 'responseJSON.errors')
      camelizedErrors = {}
      camelizedErrors[Em.String.camelize(key)] = value for key, value of errors
      record.set('errors', camelizedErrors)
    xhr
