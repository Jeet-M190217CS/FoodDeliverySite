Rails.application.routes.draw do
  root 'welcome#home'
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'
  get '/dashboard/:id', to:'users#dashboard'
  get '/orders/change_status/:id', to:'orders#change_status' 
  resources :users
  get '/res_user_reg', to:'restaurant_user_registrations#new'
  post '/res_user_reg', to:'restaurant_user_registrations#create'
  get '/cart/add/:id', to:'cart#add'
  get '/cart/clear', to:'cart#clear'
  get '/cart/remove/:id', to:'cart#remove'
  get '/cart/order', to: 'cart#order'
  resources :restaurants do
    resources :items
  end
end