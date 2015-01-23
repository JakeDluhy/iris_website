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
  resources :teams
  resources :subteams
  resources :weekly_awards, :only => [:new, :create]
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/sponsors',to: 'static_pages#sponsors',via: 'get'
  match '/backend', to: 'static_pages#backend', via: 'get'

  namespace :api do
    resources :tasks, only: [:index, :show]
    resources :updates, only: [:index, :show]
    resources :users, only: [:index, :show]
    resources :resources, only: [:index, :show]
    resources :navigation, only: [:index]
    resources :filtering, only: [:index]
  end

end