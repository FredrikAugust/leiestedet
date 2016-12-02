Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :listing

  authenticated do
    root to: 'listing#index', as: :authenticated_root
  end

  root to: 'static_page#index'

  #static_page
  get 'about', to: 'static_page#index'
end
