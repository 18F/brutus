Brutus::Application.routes.draw do
  ActiveAdmin.routes(self)
  root :to => "home#index"
  resources :users, :only => [:index, :show, :edit, :update ]
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  # custom routes for sf
  get '/sync' => 'home#sync'
  get '/app_details/:id' => 'home#app_details'

  # devise_for :users, ActiveAdmin::Devise.config
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks"}
end
