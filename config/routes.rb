Caption::Application.routes.draw do
  root 'entries#new'

  resources :entries, :only => [:create, :destroy]
  match '/entry' => 'entries#new', :via => :get, :as => :new_entry
  match '/entry/index' => 'entries#index', :via => :get, :as => :entries_index
  match '/entry/:id' => 'entries#show', :via => :get, :as => :show_entry

  resources :labels, :only => [:create]
  match 'caption/index' => 'labels#index', :via => :get, :as => :captions_index
  match 'caption/:id/up-vote' => 'labels#up_vote', :via => :put, :as => :up_vote
  match 'caption/:id/down-vote' => 'labels#down_vote', :via => :put, :as => :down_vote
  match 'caption/sort' => 'entries#sort', :via => :get, :as => :sort_captions
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
