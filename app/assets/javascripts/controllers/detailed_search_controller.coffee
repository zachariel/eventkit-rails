# ==========================================================================
# Detailed Search Controller 
# ==========================================================================
# The controller for the detailed search page where you can specify
# specific fields to search on.
#

EventKit.DetailedSearchController = Em.Controller.extend({

	readyToSearch: (->
		console.log(@get('model').length)
		@get('model').length == 0
	).property('model.length')

	actions: {
		onEventSelected: (filter, event) ->
			filter.selectedEvent = filter.events[event.target.selectedIndex]
			return

		removeFilter: (sender)->
			@get('model').removeObject(sender)

		addFilter: (type)->
			types = []
			for hash in window.EventTypes
				types.push hash

			newFilter = {
 				name: type.name
 				id: type.id
 				time: new Date().getTime()
 				key: ""
 				val: ""
 				events: types
 				selectedEvent: null
 			}

			if newFilter.id == 'event'
				newFilter.selectedEvent = newFilter.events[0]

			newFilter[type.id] = "id"

			@get('model').addObject(newFilter)
			return

		submitSearch: ()->
			model = {}

			for filter in @get('content')
				key = filter.id
				value = []
				if key == "additional_arguments"
					hash = {}
					hash[filter.key] = filter.val
					value.push JSON.stringify(hash)
				else if key == "event"
					value.push filter.selectedEvent.type
				else
					value.push filter.val

				if !model[key] then model[key] = []
				list = model[key]
				model[key] = list.concat value

			@transitionToRoute('detailedSearchResults', {
				queryParams: {
					s: JSON.stringify(model)
					p: 1
				}
			})

	}
	
	allFilters: [{
		    name: "Additional Argument"
		    id: "additional_arguments"
		}
		{
		    name: "Attempt"
		    id: "attempt"
		}
		{
		    name: "Category"
		    id: "category"
		}
		{
		    name: "Email"
		    id: "email"
		}
		{
		    name: "Event"
		    id: "event"
		}
		{
		    name: "IP"
		    id: "ip"
		}
		{
		    name: "Newsletter ID"
		    id: "newsletter_id"
		}
		{
		    name: "Newsletter Send ID"
		    id: "newsletter_send_id"
		}
		{
		    name: "Newsletter User List ID"
		    id: "newsletter_user_list_id"
		}
		{
		    name: "SMTP-ID"
		    id: "smtp-id"
		}
		{
		    name: "Reason"
		    id: "reason"
		}
		{
		    name: "Response"
		    id: "response"
		}
		{
			name: "Message ID"
		}
		{
		    name: "Status"
		    id: "status"
		}
		{
		    name: "Type"
		    id: "type"
		}
		{
		    name: "URL"
		    id: "url"
		}
		{
		    name: "User Agent"
		    id: "useragent"
		}]

})
