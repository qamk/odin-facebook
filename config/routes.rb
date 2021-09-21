Rails.application.routes.draw do
  root 'users#feed'
  resources :likes, only: %i[create destroy]
  resources :friends, only: %i[destroy]
  get '/friends-list', to: 'friends#friends_list'
  resources :friend_requests, only: %i[index create update]
  resources :posts, except: %i[index new] do
    resources :comments, only: %i[edit create update destroy]
  end
  get '/notifications', to: 'users#notifications'
  get '/timeline', to: 'users#timeline'
  get '/timeline/edit', to: 'users#edit'
  match '/timeline', to: 'users#update', via: %i[put patch]

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
