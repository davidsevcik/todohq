App.RESTAdapter = Ember.RESTAdapter.extend

  # createRecord: (record) ->
  #   @_super(record).then((->), (xhr) ->
  #     record.set('errors', errors) if errors = Em.get(xhr, 'responseJSON.errors')
  #   )

  # saveRecord: (record) ->
  #   @_super(record).then((->), (xhr) ->
  #     record.set('errors', errors) if errors = Em.get(xhr, 'responseJSON.errors')
  #   )

  buildURL: (klass, id) ->
    url = @_super(klass, id)
    if session = @constructor.sessionController.get('content')
      url += "?auth_token=#{session.get('authenticationToken')}"
    url
