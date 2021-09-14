Rails.application.routes.draw do
  get 'friends/create'
  get 'friends/destroy'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
