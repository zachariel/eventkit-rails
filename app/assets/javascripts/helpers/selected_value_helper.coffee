#/console.log('selectedValue helper registered')
myhelper = (params) ->
  a = params[0]
  b = params[1]

  return '' if a == null || b == null

  if a.value == b.value
    'selected'
  else
    ''

EventKit.SelectedValueHelper = Ember.Helper.helper(myhelper)
