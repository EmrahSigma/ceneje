Rails.application.routes.draw do
  devise_for :users

  # Root path route ("/")
  root "home#index"
  get 'most_viewed', to: 'home#most_viewed', as: 'most_viewed_products'
  # Posts routes (including show, edit, update, destroy)
  resources :posts, only: [:show, :edit, :update, :destroy] do
    resources :comments, only: [:create, :destroy]  # Nested comments inside posts
  end

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Route to the home index page
  get "home/index"

  # Routes for creating posts
  get "home/new", to: "home#new", as: "home_new"  # Show the form
  post "home/create", to: "home#create", as: "home_create"  # Handle form submission
end
