Rails.application.routes.draw do
  devise_for :users

  root to: 'static_page#about'

  resources :listing
end
