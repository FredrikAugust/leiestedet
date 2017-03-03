Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :listing

  get '/listing/:sokeord', to: 'listing#index'

  get 'profile', to: 'profile#show'
  get 'profile/:id', to: 'profile#show'

  get '/.well-known/acme-challenge/:id', to: 'static_page#acme'

  authenticated do
    root to: 'listing#index', as: :authenticated_root
  end

  root to: 'static_page#index'

  #static_page
  get '/about', action: :index, controller: :static_page
end
