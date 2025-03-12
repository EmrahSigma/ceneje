Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    delete "/users/sign_out", to: "devise/sessions#destroy"
  end

  resources :posts, only: [:index, :show, :new, :create]
  root "posts#index"
end