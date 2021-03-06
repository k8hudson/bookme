Bookme::Application.routes.draw do
  resources :events

 

  get '/users/events', to: 'users#events', as: 'users_events' 
  get '/providers/events', to: 'providers#events', as: 'providers_events' 
  resources :users 
  resources :providers
 


  get "calendar/index"

  get '/login', to: 'login#new_session', as: 'sign_in' 
  post '/login', to: 'login#create_session'
  get 'logout', to: 'login#logout', as: 'sign_out'

  get '/plogin', to: 'plogin#new_session', as: 'psign_in'
  post '/plogin', to: 'plogin#create_session'
  get 'plogout', to: 'plogin#logout'

  get '/auth/:provider/callback', to: 'login#create_session'
  get '/auth/failure', to: 'login#new_session'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
