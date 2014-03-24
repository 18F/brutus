Rails.application.config.middleware.use OmniAuth::Builder do
  provider :myusa, ENV['MYUSA_OAUTH_PROVIDER_KEY'], ENV['MYUSA_OAUTH_PROVIDER_SECRET'],
	  :client_options => {
	  		:site => ENV['MYUSA_HOME'],
	  		:token_url => "/oauth/authorize",
	  		:ssl => {
	  			:verify => false
	  		}
	  	},
  	  :scope => %w{
  			profile.email
				profile.title
				profile.first_name
				profile.middle_name
				profile.last_name
				profile.suffix
				profile.address
				profile.address2
				profile.city
				profile.state
				profile.zip
				profile.phone_number
				profile.mobile_number
				profile.gender
				profile.marital_status
				profile.is_parent
				profile.is_student
				profile.is_veteran
				profile.is_retired
			}.join(' ')
end

OmniAuth.config.on_failure = SessionsController.action(:failure)