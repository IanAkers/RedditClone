RedditClone::Application.routes.draw do
  root 'subs#index'

  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs

end
