Rails.application.routes.draw do

  get 'songs/index'

  root 'songs#index'
  resources :sessions, only: [ :new, :create, :destroy ]
  resources :users, only: [ :new, :create, :update, :edit, :show ] do

  end
  resources :songs do
    
  end
  get 'login', to: 'sessions#new', as: :login
  get 'signup', to: 'users#new', as: :signup
  delete 'logout', to: 'sessions#destroy', as: :logout

  get 'language', to: 'users#language', as: :set_locale

end
