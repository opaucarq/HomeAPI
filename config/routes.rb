Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # get post patch delete
  get "/users", to: "users#index"
  get "/users/:id", to: "users#show"
  get "/properties", to: "properties#index"
end
