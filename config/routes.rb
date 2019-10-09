Rails.application.routes.draw do
  root 'welcome#home'
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'
  get '/dashboard/:id', to:'users#dashboard'
  get '/orders/change_status/:id', to:'orders#change_status' 
  resources :users
end