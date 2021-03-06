Rails.application.routes.draw do

  resources :categories
  post 'subcategories', to: 'categories#subcategorise'
  resources :order_details
  resources :favorites
  get "sitemap.xml" => "layouts#sitemap", format: :xml, as: :sitemap
  get "robots.txt" => "layouts#robots", format: :text, as: :robots
 #cart===============
  get 'cart' => "carts#index", as: :cart
  get 'enquiry' => "carts#enqry", as: :enqry
  get 'checkout/successful' => "carts#placed", as: :order_placed
  get 'checkout', to: "carts#delivery_address", as: :checkadd
  post 'checkout', to: "carts#checkout", as: :checkout
  post 'sendenqry', to: "carts#sendenqry", as: :sendenqry
  put 'add_cart/', to: 'carts#add', as: :add_to
  put 'remove_cart/', to: 'carts#remove', as: :remove_from
  put 'addenqry/', to: 'carts#addenqry', as: :addenqry
  put 'removeenqry/', to: 'carts#removeenqry', as: :removeenqry
 #==========================================

  put 'orders/:id', to: 'orders#sdelete', as: :sdelete
  resources :orders
  post 'setlocat', to: 'home#setlocat', as: :setlocat
  root to: "home#index", as: :user
  get 'search', to: 'home#search', as: :search
  get 'help' , to: 'home#help', as: :help
  get 'about', to: 'home#about', as: :about
  get 'Research_Development', to: 'home#rnd', as: :rnd
  resources :products
  
  devise_for :users, controllers: {registrations: "users/registrations", omniauth_callbacks: "users/omniauth_callbacks"}
  get 'users/change_address', to: 'users#change_address', as: :change_address
  get 'users/:id/history', to: 'users#history', as: :history
  put 'users/:id/remove_history', to: 'users#remove_history', as: :remove_history
  get 'users/:id', to: 'users#show', as: :profile
  get 'users', to: 'users#index', as: :users
  get 'autocomplete_product_name', to: 'home#autocomplete_product_name', as: :autocomplete_product_name
  mount Monologue::Engine, at: '/blog', as: :blogs
  
  post 'stores', to: 'stores#create'


  get 'stores/new', to: 'stores#new', as: :new_store  
  get ':store/:id/new_product', to: 'stores#new_product', as: :add_new_product
  get 'products/:id/edit_product', to: 'products#edit', as: :editproduct
  get ':store/:id/manage_category', to: 'categories#new', as: :add_new_category
  get 'stores/:id/edit', to: 'stores#edit', as: :edit_store
  put 'stores/:id', to: 'stores#updateprice', as: :updateprice
  get 'stores/:storetype/:id/add', to: 'store_products#new'
  get 'stores/:id/add', to: 'store_products#new', as: :new_store_product
  get 'stores/:id/stock&price', to: 'stores#setprice', as: :setprice

  post 'stores/:id/subscribe', to: 'stores#subcsribe', as: :subscribe

  put 'stores/:id/completed', to: 'stores#completed', as: :completed
  put 'stores/:id/remove_order', to: 'stores#remove_order', as: :remove_order
  put 'stores/:id/reject_order', to: 'stores#reject_order', as: :reject_order
  put 'stores/:id/accept_order', to: 'stores#accept_order', as: :accept_order
  
  get ':store/:id/orders', to: 'stores#orders', as: :order_requests
  get ':store/:id/manage_subcategories', to: 'categories#subcategories', as: :add_subcategory
  get ':store/:id', to: 'stores#show', as: :store

  patch 'stores/:id', to: 'stores#update', as: :update_store
  put 'stores/:id', to: 'stores#update'
  delete 'stores/:id', to: 'stores#destroy', as: :delete_store

  get 'store_products', to: 'store_products#index', as: :store_products
  post 'store_products/:id', to: 'store_products#create', as: :create_store_product

  get 'store_products/:id/edit', to: 'store_products#edit', as: :edit_store_product
  get 'store_products/:id', to: 'store_products#show', as: :store_product
  patch 'store_products/:id', to: 'store_products#update'
  put 'store_products/:id', to: 'tore_products#update'
  delete 'store_products/:id', to: 'store_products#destroy'
  get ':storetype', to: 'stores#index', as: :storetype #retail wholesale etc
end
