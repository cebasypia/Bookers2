Rails.application.routes.draw do
  root 'home#top'
  get 'home/about'
  devise_for :users
  resources :users, only: [:show, :index, :edit, :update]
  resources :books
end
