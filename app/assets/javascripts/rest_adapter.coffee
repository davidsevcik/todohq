App.RESTAdapter = Ember.RESTAdapter.extend

  createRecord: (record) ->
    @_super(record).then((->), (xhr) ->
      record.set('errors', errors) if errors = Em.get(xhr, 'responseJSON.errors')
    )

  saveRecord: (record) ->
    @_super(record).then((->), (xhr) ->
      record.set('errors', errors) if errors = Em.get(xhr, 'responseJSON.errors')
    )
