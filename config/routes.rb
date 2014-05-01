Brutus::Application.routes.draw do
  ActiveAdmin.routes(self)
  root :to => "home#index"

  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  # custom routes for sf
  get '/admin/sync' => 'home#sync'
  get '/admin/app_details/:id' => 'home#app_details'
  get '/admin/mark_junk/:id' => 'home#mark_junk', :as => :mark_junk
  # custom routes for ajax-y dashboard
  get '/admin/fetch_flagged_apps' => 'home#fetch_flagged_apps'
  get '/admin/fetch_recent_apps' => 'home#fetch_recent_apps'
  get '/admin/fetch_recent_reviews' => 'home#fetch_recent_reviews'
  get '/admin/fetch_related_apps/:tag_list' => 'home#fetch_related_apps'

  # devise_for :users, ActiveAdmin::Devise.config
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks"}
end
