Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "pong", to: "pings#index"
  post "signup", to: "users#create"
  get "users/:id", to: "users#show"
  get "users", to: "users#index"
  patch "users/:id", to: "users#update"
  post "users/close", to: "users#destroy"
  # Defines the root path route ("/")
  # root "articles#index"
end

#docker-compose exec web bashでdocker内にはいる