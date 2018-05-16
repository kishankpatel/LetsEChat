Rails.application.routes.draw do
  root 'home#index'

  devise_for :users

  resources :conversations, only: [:create] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end
  mount ActionCable.server => '/cable'
  get "/conversations", to: "conversations#create"
end