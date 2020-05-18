Rails.application.routes.draw do
  get 'book_comments/create'
  get 'book_comments/destroy'
  devise_for :users

  resources :users, only: [:show, :index, :edit, :update]
  resources :books do
    resources :favorites, only: [:create, :destroy]
  end

  root 'home#top'
  get 'home/about'
end
