Rails.application.routes.draw do
  # Root path route ("/")
  root "home#index"

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Route to the home index page (if needed)
  get "home/index"
end