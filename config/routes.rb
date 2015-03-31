IrisWebsite::Application.routes.draw do
  root "static_pages#home"
  resources :users
  match '/users/:id/join_teams' => 'users#join_teams', :via => :put
  resources :sessions, only: [:new, :create, :destroy]
  resources :updates
  resources :tutorials
  resources :instructions, :except => [:create]
  resources :instructions, :only => [:create], :format => :json
  resources :tasks
  resources :tests
  resources :test_objectives
  resources :test_comments, :only => [:new, :create, :update, :destroy]
  resources :test_assignments, :only => [:create]
  resources :teams
  resources :subteams
  resources :weekly_awards, :only => [:new, :create]
  match '/signup',    to: 'users#new',                 via: 'get'
  match '/signin',    to: 'sessions#new',              via: 'get'
  match '/signout',   to: 'sessions#destroy',          via: 'delete'
  match '/greetings', to: 'static_pages#greetings',    via: 'get'
  match '/greetings', to: 'static_pages#email_signup', via: 'post'
  match '/about',     to: 'static_pages#about',        via: 'get'
  match '/contact',   to: 'static_pages#contact',      via: 'get'
  match '/sponsors',  to: 'static_pages#sponsors',     via: 'get'
  match '/sponsors_packet', to: 'static_pages#sponsors_packet', via: 'get'
  match '/outreach',  to: 'static_pages#outreach',     via: 'get'
  match '/backend',   to: 'static_pages#backend',      via: 'get'

  namespace :api do
    resources :tasks, only: [:index, :show]
    resources :tests, only: [:index, :show]
    resources :updates, only: [:index, :show]
    resources :users, only: [:index, :show]
    resources :resources, only: [:index, :show]
    resources :navigation, only: [:index]
    resources :filtering, only: [:index]
  end

end