Stocklist::Application.routes.draw do

  # --- REST API ---
  resources :products

  get 'stocklist' => 'stocklist#index'
  get 'stocklist/:id' => 'stocklist#show'
  post 'stocklist' => 'stocklist#create'
  post 'stocklist/:id' => 'stocklist#save'

  get 'user' => 'users#get'
  post 'users' => 'users#create'
  post 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

  # --- STATIC PAGES ----
  root :to => 'static#index'

end
