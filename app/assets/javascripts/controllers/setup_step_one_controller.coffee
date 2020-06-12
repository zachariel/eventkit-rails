# ==========================================================================
# Setup Step One Controller 
# ==========================================================================
# The controller for the first step of the setup wizard that sets up
# a username and password.
#

EventKit.SetupStepOneController = Em.Controller.extend({

  setup:  Ember.inject.controller('setup')

	actions: {
		submitBasicAuth: ()->
			if @get('model').get('meetsCriteria') #@get('controllers.setup.model.meetsCriteria')
				@transitionToRoute('setup.StepTwo')
	}

})
