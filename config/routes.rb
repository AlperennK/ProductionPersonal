Rails.application.routes.draw do
  resources :articles
  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  root 'pages#home'
  get 'art', to: 'pages#art'
  get 'about', to:'pages#about'
  get 'teaching', to:'pages#teaching'
  delete 'logout', to: 'sessions#destroy'

  #It means when we have get request for about send it to pages#about
end
