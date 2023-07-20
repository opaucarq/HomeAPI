Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # get post patch delete
  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"

  get "/props", to: "user_properties#index"

  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/properties", to: "properties#index"
  get "/properties/:id", to: "properties#show"
  post "/properties", to: "properties#create"
  patch "/properties/:id", to: "properties#update"
  delete "/properties/:id", to: "properties#destroy"
end
