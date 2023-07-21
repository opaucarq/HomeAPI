Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # get post patch delete

  get "/profile", to: "users#show"
  post "/users", to: "users#create"

  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/props", to: "user_properties#index"
  get "/props/:id", to: "user_properties#show"

  post "/props", to: "properties#create"
  patch "/props/:id", to: "properties#update"
  delete "/props/:id", to: "properties#destroy"

  get "/properties", to: "properties#index"
  get "/properties/:id", to: "properties#show"
end
