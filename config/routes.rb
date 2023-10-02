Rails.application.routes.draw do
  
  # get '/', to: 'articles#index'
  root 'articles#index'
  
  resources :payments, only: [:show]
  resources :orders, only: [:index, :show, :create] 
  
  resources :articles do
    member do
      patch :unlock
    end
    resources :comments, shallow: true, only: [:create, :destroy]
  end
  

  resource :users, except: [:show, :destroy ] do
    collection do
      get :login
      post :logining
      delete :logout
    end
  end

  resources :albums

  namespace :api do
    namespace :v1 do
      resources :articles, only: [] do
        member do
          patch :like
        end
      end
    end
  end
  get '/about', to: 'pages#about'
  get '/pricing', to: 'pages#pricing'
end
