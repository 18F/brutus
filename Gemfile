source 'https://rubygems.org'
ruby '2.1.3'
gem 'rails', '4.1.5'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'bootstrap-sass', '>= 3.0.0.0'
gem 'cancan'
gem 'figaro'
gem 'omniauth'
gem 'omniauth-myusa', :git => 'https://github.com/GSA/omniauth-myusa.git'
gem 'rolify'
gem 'simple_form'
gem 'slim'
gem 'thin'
gem 'redis-rails'
gem 'redis-namespace'
gem 'resque', '~> 2.0.0.pre.1', :github => 'resque/resque'
gem 'activeadmin', github: 'activeadmin/activeadmin'
gem 'active-resource-pagination'
gem 'activeresource', require: 'active_resource'
gem 'httparty'
gem 'acts-as-taggable-on'
gem 'restforce', :github => 'amoose/restforce'
gem 'dalli'
gem 'public_activity'
gem 'newrelic_rpm'
gem 'twilio-ruby', '~> 3.11'
gem 'randumb'
gem 'secure_headers'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'haml-rails'
  gem 'haml2slim'
  gem 'html2haml'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'capistrano', '~> 3.1'
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1.1'
  # gem 'capistrano-maintenance', github: "capistrano/capistrano-maintenance"
  gem "capistrano-resque", "~> 0.2.1", require: false
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'sqlite3'
  gem 'pry'
  gem 'pry-nav'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner', '1.0.1'
  gem 'email_spec'
end
group :production do
  gem 'pg'
  gem 'rails_12factor'
end