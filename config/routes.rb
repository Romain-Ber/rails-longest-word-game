Rails.application.routes.draw do
  get "new", to: "games#new"
  post "score", to: "games#score"
  # Defines the root path route ("/")
  # root "posts#index"
end
