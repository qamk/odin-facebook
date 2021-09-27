Rails.application.routes.draw do
  root 'users#feed'

  # Friends routes
  resources :friends, only: %i[destroy]
  get '/friends-list', to: 'friends#friends_list'
  # Friend Request routes
  resources :friend_requests, only: %i[index create update destroy]
  # Post and Comments routes
  resources :posts, except: %i[index new] do
    resources :comments, only: %i[edit create update destroy]
  end
  # Likes routes
  post '/likes', to: 'likes#like_unlike_toggle'
  # Users routes
  resolve('User') { [:timeline] }
  # get '/search', to: 'users#search'
  get '/timeline', to: 'users#timeline'
  get '/users/:id/timeline', to: 'users#show', as: 'user'
  get 'users', to: 'users#index'
  get '/timeline/edit', to: 'users#edit'
  match '/timeline', to: 'users#update', via: %i[put patch]

  # Devise routes (users)
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
