BIG BRUTUS
=========
Doing heavy lifting in the land of government hiring.<br />
<img src="http://www.kansassampler.org/siteassets/brutis3.jpg" /><br /><br />


This application was generated using [RailsApps Composer](http://railsapps.github.io/rails-composer/) with OmniAuth and the [MyUSA strategy](https://github.com/GSA-OCSIT/omniauth-myusa) for authentication.


Inspired by the work of [Presidential Innovation Fellows](http://www.whitehouse.gov/innovationfellows).

## How To Get Started
  - Clone repo (`git clone git@github.com:18f/brutus.git`)
  - Install the bundle (`bundle install`)
  - Rename application.yml.example (`cp application.example.yml application.yml`)
  - Register your application 
    - with [MyUSA](http://my.usa.gov) (Redirect URI: [host]/auth/myusa/callback)
    - OR for loal dev register with QA server [MyUSA](http://qa.my.usa.gov) (Redirect URI: http://localhost:3000/auth/myusa/callback)
  - edit application.yaml
    - MYUSA_OAUTH_PROVIDER_KEY should be your Auth Client ID from MyUSA
    - MYUSA_OAUTH_PROVIDER_SECRET should be your Auth Client Secret from MyUSA
  - Install redis and memcache.  Redis will attempt to run automatically at startup.
  - rake db:setup
  - Fire up rails! (`rails s`)


## Diagnostics

Recipes:
[“apps4”, “controllers”, “core”, “email”, “extras”, “frontend”, “gems”, “git”, “init”, “models”, “prelaunch”, “railsapps”, “readme”, “routes”, “saas”, “setup”, “testing”, “views”]

Preferences:
{:git=>true, :apps4=>"none", :dev_webserver=>"thin", :prod_webserver=>"thin", :database=>"sqlite", :templates=>"slim", :unit_test=>"rspec", :integration=>"rspec-capybara", :continuous_testing=>"none", :fixtures=>"factory_girl", :frontend=>"bootstrap3", :email=>"gmail", :authentication=>"omniauth", :omniauth_provider=>"twitter", :authorization=>"cancan", :form_builder=>"simple_form", :starter_app=>"users_app", :rvmrc=>true, :quiet_assets=>true, :local_env_file=>true, :better_errors=>true, :github=>true}


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


License
--

Coming soon.
