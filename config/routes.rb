Stocklist::Application.routes.draw do

  # --- REST API ---
  resources :products

  get 'stocklist' => 'stocklist#index'
  get 'stocklist/:id' => 'stocklist#show'
  post 'stocklist/:id/add' => 'stocklist#add'
  post 'stocklist/:id/remove' => 'stocklist#remove'

  post 'product_stock/:id/quantity' => 'product_stock#quantity'

  get 'user' => 'users#get'
  post 'signup' => 'users#create'
  post 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'

  # --- STATIC PAGES ----
  root :to => 'static#index'

end
