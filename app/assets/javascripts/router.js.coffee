# ==========================================================================
# Router
# ==========================================================================
# Lays out all the front end routes for the Ember Framework.
#

EventKit.Router.map ()->

	# HOME ROUTE
	# The main home page/dashboard.
	#=========================================================================#
	@route 'home', {
		path: '/'
	}

	# EVENT ROUTE
	# Displays the information for a specific event.
	#=========================================================================#
	@route 'event', {
		path: '/event/:id'	
	}

	# SETTINGS ROUTE
	# The settings page.
	#=========================================================================#
	@route 'settings', {
		path: '/settings'
	}

	# USER SETTINGS ROUTE
	# The page for editing an existing user (change permissions/password)
	#=========================================================================#
	@route 'user', {
		path: '/settings/user/:id'
	}

	# SEARCH RESULTS ROUTE
	# The results page for the wild card search field in the navigation bar.
	#=========================================================================#
	@route 'searchResults', {
        path: '/search/:query/page/:page'
    }

	# DETAILED SEARCH ROUTE
	# The detailed search page that allows a user to specify search terms
	# for specific fields.
	#=========================================================================#
	@route 'detailedSearch', {
		path: '/search/detailed'
	}

	# DETAILED SEARCH RESULTS ROUTE
	# The results of the detailed search.
	#=========================================================================#
	@route 'detailedSearchResults', {
		path: '/search/detailed/results'
	}

	# SETUP ROUTE
	# The setup wizard that gets run during the first load.
	#=========================================================================#
	@route 'setup', {
			path: '/setup/step'
		}, ()->
			@route 'StepOne', {
				path: '/1'	
			}

			@route 'StepTwo', {
				path: '/2'
			}

			@route 'StepThree', {
				path: '/3'
			}

	# 404 NOT FOUND
	# Used if the user goes to a route that doesn't exist.
	#=========================================================================#
	@route 'notFound', {
		path: '*path'
	}
