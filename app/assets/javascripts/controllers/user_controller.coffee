# ==========================================================================
# User Controller 
# ==========================================================================
# The controller for the edit user page.
#

EventKit.UserController = Em.Controller.extend {

	application: Ember.inject.controller('application')

	loggedInAs: (->
		@get 'application.user'
	).property('application.user.id')

	viewingLoggedInUser: (->
		@get('application.user.id') == @get('model.id')
	).property('application.user.id', 'model.id')

	buttonClass: (->
		if @get 'viewingLoggedInUser'
			return 'col-md-6'
		else
			return 'col-md-4'
	).property('viewingLoggedInUser')

	actions: {

		save: ()->
			self = @
			user = @get 'model'
			if user.get('update.passwordMatches')
				if user.get('update.password').length and user.get('update.confirmPassword').length
					user.set('password', user.get('update.password'))

				user.save().then(
					(user)->
						user.get('update').reset()
						alert "User updates saved!"
						self.transitionToRoute 'settings'
					(error, user)->
						if error.status == 409
							alert "Could not save new user because that username already exists!"
							self.get('model').rollback()
						else
							alert 'Uh oh! Something went wrong. Please try again.'
				)
			else
				alert "The passwords don't match!"

		cancel: ()->
			@get('model').rollback()
			@transitionToRoute 'settings'

		deleteUser: ()->
			if confirm "Are you sure you want to delete the user \"" + @get('model').get('username') + "\"?"
				self = @
				@get('model').destroyRecord().then(()->
					self.transitionToRoute 'settings'
				)

	}

}
