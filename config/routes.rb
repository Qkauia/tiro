Rails.application.routes.draw do
  get '/about', to: 'pages#about'
  # get '/', to: 'articles#index'
  root 'articles#index'
  
  # get '/articles', to: 'articles#index'
  # get '/articles/new', to: 'articles#new', as: 'new_article'
  # post '/articles', to: 'articles#create'
  # #單一頁面
  # get '/articles/:id', to: 'articles#show', as: 'article'
  # get '/articles/:id/edit', to: 'articles#edit', as: 'edit_article'
  # patch 'articles/:id', to: 'articles#update'
  # delete 'articles/:id', to: 'articles#destroy'
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

  namespace :api do
    namespace :v1 do
      resources :articles, only: [] do
        member do
          patch :like
        end
      end
    end
  end
end
