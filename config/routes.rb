Rails.application.routes.draw do
  resources :posts, only: [:index]

  root 'users#index'
  resources :users do 
    resources :posts 
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
end
