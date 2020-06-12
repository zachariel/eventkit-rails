# ==========================================================================
# Settings Controller 
# ==========================================================================
# The controller for the settings page.
#

EventKit.SettingsController = Em.Controller.extend({

	modelDidChange: (->
		self = @

		# Get the Autodelete Setting
		@store.query('setting', {
			name: "autodelete_time"
		}).then((results)->
			setting = results.get('firstObject')
			value = setting.get('value') * 1
			self.set('autodeleteSelectedValue', self.get('autodelete')[value])
			console.log(self.get('autodeleteSelectedValue'))
		)

		# Get the user list
		@store.findAll('user').then(
			(users)->
				self.set('loadedUsers', true)
				if users then self.set('users', users.sortBy('username'))
				users
			(response)->
				self.set('loadedUsers', true)
		)
	).observes('model')

	endpoint: (->
		protocol = window.location.protocol + "//"
		hash = window.location.hash
		url = window.location.href.replace(protocol, "").replace(hash, "")
		return new Ember.String.htmlSafe "<pre><code>" + protocol + "[username]:[password]@" + url + "</code></pre>"
	).property()


	# AUTO DELETE SETTING
	#=========================================================================#

	autodelete: [
		{
			label: "Never"
			value: 0
		}
		{
			label: "1 month"
			value: 1
		}
		{
			label: "2 months"
			value: 2
		}
		{
			label: "3 months"
			value: 3
		}
		{
			label: "4 months"
			value: 4
		}
		{
			label: "5 months"
			value: 5
		}
		{
			label: "6 months"
			value: 6
		}
		{
			label: "7 months"
			value: 7
		}
		{
			label: "8 months"
			value: 8
		}
		{
			label: "9 months"
			value: 9
		}
		{
			label: "10 months"
			value: 10
		}
		{
			label: "11 months"
			value: 11
		}
		{
			label: "12 months"
			value: 12
		}
	]

	autodeleteSelectedValue: null

	autodeleteSubtext: (->
		if @get('autodeleteSelectedValue.value') == 0
			'WARNING! Never deleting events from your database could result in a very large database which might impact performance.  If you\'re using Heroku, there might be a limit on the number of events your database can hold, and might require upgrading your database plan.'
		else
			'Please note that if you\'re using Heroku, there may be limitations on the number of events your database can hold. See your Heroku account for more information.'
	).property('autodeleteSelectedValue')


	# USERS
	#=========================================================================#

	users: null
	loadedUsers: false

	saving: false
	showAddUser: false
	newUser: EventKit.HttpBasicAuth.create()

	validUser: (->
		!@get('newUser').get('meetsCriteria')
	).property('newUser.username', 'newUser.password', 'newUser.confirmPassword')

	# ACTIONS
	#=========================================================================#

	actions: {
		onAutodeleteSelected: (value)->
			console.log(@get('autodelete')[value])
			@set('autodeleteSelectedValue',  @get('autodelete')[value])

		save: ()->
			self = @
			@set('saving', true)
			@store.query('setting', {
				name: "autodelete_time"
			}).then((results)->
				setting = results.get('firstObject')
				setting.set('value', self.get('autodeleteSelectedValue.value'))
				setting.save().then(()->
					alert 'Your changes have been saved!'
					self.set('saving', false)
				)
			)

		toggleAddUser: ()->
			@get('newUser').reset()
			@set('showAddUser', !@get('showAddUser'))
			false

		addNewUser: ()->
			if @get('newUser.meetsCriteria')
				u = @get('newUser.username')
				p = @get('newUser.password')

				self = @
				@store.createRecord('user', {
					username: u
					password: p
				}).save().then(
					(user)->
						self.set('showAddUser', false)
						self.set('model', new Date())
					(error, user)->
						if error.status == 409
							alert "Could not save new user because that username already exists!"
						else 
							alert "Yikes! Something went wrong, please try again."
						window.location.reload()
				)

		editUser: (user)->
			@transitionToRoute 'user', user

	}

})
