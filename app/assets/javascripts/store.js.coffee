EventKit.ApplicationStore = DS.Store.extend()

# Override the default adapter with the `DS.ActiveModelAdapter` which
# is built to work nicely with the ActiveModel::Serializers gem.
EventKit.ApplicationAdapter = DS.RESTAdapter.extend({
  namespace: 'api/v1'
  ajax: (url, type, hash) ->
    hash = hash || {};
    hash.beforeSend = (xhr)->
      xhr.setRequestHeader("X-Requesting-Application", "EVENTKIT-RAILS");
      if window.token
        xhr.setRequestHeader('X-Auth-Token', window.token)
    @_super(url, type, hash);

  handleResponse: (status, headers, payload, requestData) ->
    #console.log(payload)
    #console.log(headers)
    if status <= 304
      return payload
    else
      return DS.InvalidError()

  #updateRecord: (store, type, snapshot) ->
  #  console.log(store)
  #  console.log(type)
  #  console.log(snapshot)
})
