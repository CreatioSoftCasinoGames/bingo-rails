Rails.application.routes.draw do

  resources :rounds

  resources :tables

  resources :table_configs

  resources :rooms

  devise_for :users
  get "utility/show_api_key", to: "utility#show_api_key", as: "show_api_key"
  post "utility/generate_api_key", to: "utility#generate_api_key", as: "generate_api_key"


  namespace :api do
    namespace :v1 do
      resources :table_configs
      resources :users
      resources :rooms
      resources :sessions, only: [:create]
      resources :table_config_users, only: [:create]
      resources :users do
        member do
          put :incr_daubs
          put :incr_ticket
          put :incr_bonus
          put :incr_mystery_chests
          put :incr_daubs_collected
          put :incr_keys_collected
          put :incr_bingo_vertical
          put :incr_bingo_horizontal
          put :incr_bingo_diagonal
          put :incr_coins_collected
        end
      end
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
