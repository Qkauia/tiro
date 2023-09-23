Rails.application.routes.draw do
  get '/about', to: 'pages#about'
  get '/articles', to: 'articles#index'
end
