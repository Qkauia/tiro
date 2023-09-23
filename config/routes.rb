Rails.application.routes.draw do
  get '/about', to: 'pages#about'
  # get '/', to: 'articles#index'
  root 'articles#index'
  get '/articles', to: 'articles#index'
  get '/articles/new', to: 'articles#new'

  # resources :articles
end
