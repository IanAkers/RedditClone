RedditClone::Application.routes.draw do
  root 'subs#index'

  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs do
    resources :posts, only: :new
  end
  resources :posts, only: [:edit, :update, :create, :destroy] do
    resources :comments, only: :new
  end

  resources :comments, only: [:create, :destroy]

end
