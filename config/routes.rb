Rails.application.routes.draw do
  get 'chats/show'
  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create]
  devise_for :users
  
  root to: 'homes#top'
  get "/home/about" => "homes#about"
  get 'search' => 'searches#search'

  resources :books do
  resource :favorites, only: [:create, :destroy]
  resources :book_comments, only: [:create, :destroy]
  end
  
  resources :users do
  resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
end
