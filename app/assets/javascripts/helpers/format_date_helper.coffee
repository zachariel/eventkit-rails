# ==========================================================================
# Format Date Helper 
# ==========================================================================
# A custom handlebar helper to format a unix timestamp to a localized 
# string.
#

EventKit.FormatDateHelper = Ember.Helper.helper((unix)->
	date = new Date(unix * 1000)
	date.toLocaleDateString() + " at " + date.toLocaleTimeString()
)
