Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "/home/about" => "homes#about"
  post "/books/new" => "books#create"

  resources :books
  resources :users

end
