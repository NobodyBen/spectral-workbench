SpectralWorkbench::Application.routes.draw do
  match 'offline' => 'users#offline'
  match 'local/:login' => 'sessions#local'
  match 'logout' => 'sessions#destroy'
  match 'login' => 'sessions#new'
  match 'register' => 'users#create'
  match 'signup' => 'users#new'
  match 'users' => 'users#list'
  match 'contributors' => 'users#contributors'
  resources :users
  resource :session

  # countertop spectrometer and device paths
  match 'key/:id' => 'device#create_key'
  match 'lookup' => 'device#lookup'
  match 'device/claim' => 'device#claim'

  match 'capture' => 'capture#index'
  match 'upload' => "spectrums#new"
  match 'capture/beta' => "capture#index", :alt => "true"
  match 'capture/legacy' => "capture#index", :legacy => "true"

  # Registered user pages:
  match 'profile' => 'users#profile'
  match 'profile/:id' => 'users#profile'
  match 'macro/:author/:id' => 'macros#show'
  match 'macro/:author/:id.:format' => 'macros#show'
  match 'dashboard' => 'users#dashboard'
  match 'popular' => 'likes#index'
  match 'popular/recent' => 'likes#recent'
  match 'comments' => 'comments#index'
  match 'comment/create/:id' => 'comments#create'

  match 'session' => "session#create", :conditions => { :method => :get }
  #match 'session' => "session#create", :requirements => { :method => :get }

  resources :videos
  match 'spectra/assign' => 'spectrums#assign'
  match 'tag/create' => 'tag#create'
  match 'tag/:id' => 'tag#show'
  match 'tag/:id.:format' => "tag#show"
  match 'tags' => 'tag#index'

  resources :spectrums
  resources :spectra_sets
  resources :comments, :belongs_to => :spectrums

  match 'message' => "users#message"

  match 'stats' => "spectrums#stats"
  match 'spectra/feed' => "spectrums#rss"
  match 'spectra/search' => "spectrums#search"
  match 'spectra/anonymous' => "spectrums#anonymous"
  match 'spectra/search/:id' => "spectrums#search"
  match 'search/:id' => "spectrums#search"
  match 'spectra/plotsfeed' => "spectrums#plots_rss"
  match 'spectra/feed/:author' => "spectrums#rss"
  match 'spectra/:id' => "spectrums#show"
  match 'spectra/:action/:id' => "spectrums"
  match 'spectra/show/:id.:format' => "analyze#spectrum"

  match 'analyze/:action/:id' => "analyze"

  # Here comes the matching controller
  match 'match/livesearch' => "match#livesearch"
  match 'match/:id' => "match#index"

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'spectrums#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.

  match ':controller(/:action(/:id))(.:format)'

end
