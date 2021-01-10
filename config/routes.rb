Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "homes#index"
  resources :users
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/open', to: 'courses#open'
  get '/close', to: 'courses#close'
  post '/open', to: 'courses#open'
  post '/close', to: 'courses#close'
  get '/add', to:'courses#add'
  post 'add', to:'courses#increase'
  get '/write', to:'grades#write'
  post '/write', to: 'grades#write'
  get '/done', to:'grades#done'
  post 'done', to:'grades#done'
  get 'succ', to:'courses#succ'
  post 'succ', to:'courses#succ'
  get '/browse', to:'grades#browse'
  resources :courses do
    member do
      post :select
      post :quit
    end
    collection do
      get :list
      post :list
      get :studentselected
      get :subcredit
      
    end
  end
  resources :grades do
    member do
      post :score
      post :done
      get :studentsscorelist
    end
    collection do
      get :scorelist
      
    end
  end
end
