Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "ping", to: "pings#index"
  post "signup", to: "users#create"
  # Defines the root path route ("/")
  # root "articles#index"
end

#docker-compose exec web bashでdocker内にはいる