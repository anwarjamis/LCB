Rails.application.routes.draw do
  resources :tickets, only: %i[index new create destroy]
  resources :tickets, only: [:show], format: { pdf: true }
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
