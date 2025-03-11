Rails.application.routes.draw do
  devise_for :users
  resources :posts, only: [:index, :show, :new, :create]
  root 'posts#index'
end