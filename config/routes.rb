Rails.application.routes.draw do
  root 'users#feed'
  resources :friends, only: %i[destroy]
  get '/friends-list', to: 'friends#friends_list'
  resources :friend_requests, only: %i[index create update]
  resources :posts, except: %i[index new] do
    resources :comments, only: %i[edit create update destroy]
  end
  resolve('User') { [:timeline] }
  post '/likes', to: 'likes#like_unlike_toggle'
  get '/notifications', to: 'users#notifications'
  get '/timeline', to: 'users#timeline'
  get '/users/:id/timeline', to: 'users#show', as: 'user'
  get '/timeline/edit', to: 'users#edit'
  match '/timeline', to: 'users#update', via: %i[put patch]

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
