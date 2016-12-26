Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :listing

  get 'profile', to: 'profile#show'

  authenticated do
    root to: 'listing#index', as: :authenticated_root
  end

  root to: 'static_page#index'

  #static_page
  get '/about', action: :index, controller: :static_page
end
