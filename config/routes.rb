Rails.application.routes.draw do
  get 'group/new'

  get 'group/create'

  get 'group/show'

  root 'home#index'

  devise_for :users

  resources :conversations, only: [:create] do
    member do
      post :close
    end
    resources :messages, only: [:create]
  end
  # mount ActionCable.server => '/cable'
  get "/conversations", to: "conversations#create"
  get "/groups/new", to: "groups#new"
  get "/groups/:id" => "groups#show"
  post "/groups/create", to: "groups#create"
  post "/group_messages/create" => "group_message#create", :as => :group_messages
  post "/user_groups/create" => "user_groups#create"
  get "/my_contacts" => "user_groups#my_contacts"
  get "/groups/edit/:id" => "groups#edit"
  patch "/groups/update/:id" => "groups#update"
  get "/groups/image/:id" => "groups#image"
  get "/users/profile" => "users#show"
  get "/users/edit/:id" => "users#edit"
  patch "/users/update/:id" => "users#update"
  get "/users/image/:id" => "users#image"
end