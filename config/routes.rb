Rails.application.routes.draw do
  resources :posts, only: [:index]

  root 'users#index'
  resources :users do 
    resources :posts 
  end
  
end
