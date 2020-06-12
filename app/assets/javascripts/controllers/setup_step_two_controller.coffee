# ==========================================================================
# Setup Step Three Controller 
# ==========================================================================
# The controller for the third and final step of the setup wizard that 
# shows that the setup is complete.
#

EventKit.SetupStepTwoController = Em.Controller.extend({

	setup: Ember.inject.controller('setup')

	###
	username: (->
		@get('model').get('username')
	).property()

	password: (->
		@get('model').get('password')
	).property()

	endpoint: (->
		protocol = window.location.protocol + "//"
		hash = window.location.hash
		url = window.location.href.replace(protocol, "").replace(hash, "")
		model = @get('setup').get('model')
		fullURL = protocol + encodeURIComponent(model.get('username')) + ":" + encodeURIComponent(model.get('password')) + "@" + url
		return new Ember.String.htmlSafe '<pre><code>' + fullURL + '</code></pre>'
	).property('username', 'password')
	###
	actions: {
		nextStep: ()->
			u = @get('setup').get('model').get('username') #@get('model').get('username')
			p = @get('setup').get('model').get('password') #@get('model').get('password')

			self = @

			goToStepThree = ()->
				self.get('setup').get('model').reset()
				self.store.query('setting', {
					name: "is_setup"
				}).then((data)->
					setting = data.get('firstObject')
					setting.set('value', '1')
					setting.save().then(()->
						self.transitionToRoute('setup.StepThree')
					)
				)

			@store.query('user', {
				username: u
			}).then((setting)->
				if setting and setting.get('length')
					auth = setting.get('firstObject')
					auth.set('username', u)
					auth.set('password', p)
					window.token = auth.get('token')
					auth.save().then(goToStepThree)
				else
					self.store.createRecord('user', {
						username: u
						password: p
					}).save().then((user)->
						window.token = user.get('token')
						goToStepThree()
					)
			)
	}

})
