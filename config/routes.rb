Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:show, :index, :edit, :update] do
    get 'relationships/followings', as: 'followings'
    get 'relationships/followers', as: 'followers'
  end
  resources :books do
    resources :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]

  root 'home#top'
  get 'home/about'
end
